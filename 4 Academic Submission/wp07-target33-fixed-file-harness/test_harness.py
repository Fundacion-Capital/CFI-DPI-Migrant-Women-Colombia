import hashlib
from pathlib import Path
import threading
import unittest
from unittest.mock import patch

import harness as h


class HarnessTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.capacity, cls.cancel = h.load_specs(Path(__file__).resolve().parent.parent)

    def owner(self, cancel=False):
        self.now=0
        return h.OwnedFixture(self.cancel if cancel else self.capacity,lambda:self.now)

    def test_p2_exact_bytes_via_short_reference_and_four_calls(self):
        owner=self.owner()
        for step in self.capacity:
            frame=owner.reserve()
            self.assertLessEqual(len(frame),8192)
            handed_off = []
            received=owner.select(frame, handed_off.append)
            self.assertEqual(len(handed_off), 1)
            self.assertIs(handed_off[0], received)
            self.assertEqual(len(received),step.size)
            self.assertEqual(hashlib.sha256(received).hexdigest(),step.sha256)
        self.assertEqual(owner.completed,4)
        self.assertTrue(owner.close(owner.fixture_closure()))
        with self.assertRaises(ValueError):
            owner.reserve()

    def test_authentication_scope_and_replay_fail_closed(self):
        for fault in ('tampered','foreign','replay'):
            with self.subTest(fault=fault):
                owner=self.owner()
                frame=owner.reserve()
                if fault=='tampered':
                    frame=frame.replace(b'P1',b'P2')
                if fault=='foreign':
                    frame=self.owner().reserve()
                if fault=='replay':
                    owner.select(frame)
                with self.assertRaises(ValueError):
                    owner.select(frame)
                self.assertTrue(owner.held)

    def test_changed_truncated_and_aliased_source_rejected(self):
        for fault in ('changed','truncated','aliased'):
            with self.subTest(fault=fault):
                owner=self.owner()
                frame=owner.reserve()
                original=self.capacity[0].path
                if fault=='aliased':
                    with patch.object(Path,'resolve',return_value=original.with_name('foreign.do')):
                        with self.assertRaises(ValueError):
                            owner.select(frame)
                else:
                    body=original.read_bytes()
                    body=(b'X'+body[1:]) if fault=='changed' else body[:-1]
                    from io import BytesIO
                    with patch.object(Path,'open',return_value=BytesIO(body)):
                        with self.assertRaises(ValueError):
                            owner.select(frame)
                self.assertEqual(owner.completed,0)
                self.assertTrue(owner.held)

    def test_no_completion_at_deadline(self):
        owner=self.owner()
        frame=owner.reserve()
        self.now=45
        with self.assertRaises(ValueError):
            owner.select(frame)
        self.assertEqual(owner.completed,0)

    def test_independent_cancel_while_worker_is_blocked(self):
        owner=self.owner(cancel=True)
        entered,release=threading.Event(),threading.Event()
        result=[]
        def blocked(body):
            entered.set()
            if not release.wait(3):
                raise RuntimeError('fixture did not release')
        def worker(frame):
            try:
                owner.select(frame,blocked)
            except ValueError:
                result.append('not_completed')
        thread=threading.Thread(target=worker,args=(owner.reserve(),))
        thread.start()
        try:
            self.assertTrue(entered.wait(2))
            self.now=40
            self.assertTrue(owner.stop(owner.stop_capability))
            self.assertTrue(thread.is_alive())
            self.assertFalse(owner.stop(owner.stop_capability))
        finally:
            self.now=41
            release.set()
            thread.join(3)
        self.assertFalse(thread.is_alive())
        self.assertEqual(result,['not_completed'])
        self.assertEqual(owner.completed,0)
        self.assertTrue(owner.close(owner.fixture_closure()))

    def test_foreign_stop_and_incomplete_closure_not_accepted(self):
        owner=self.owner(cancel=True)
        with self.assertRaises(ValueError):
            owner.stop(self.owner(cancel=True).stop_capability)
        self.assertFalse(owner.close(owner.fixture_closure()))
        owner=self.owner()
        for _ in range(4):
            owner.select(owner.reserve())
        self.assertFalse(owner.close({**owner.fixture_closure(),'retained_handles':1}))
        self.assertFalse(owner.close(owner.fixture_closure()))

    def test_cleanup_ceiling_is_exclusive(self):
        owner=self.owner()
        for _ in range(4):
            owner.select(owner.reserve())
        self.now=30
        self.assertFalse(owner.close(owner.fixture_closure()))

    def test_work_ceiling_and_post_handoff_deadline(self):
        owner = self.owner()
        self.now = 179
        frame = owner.reserve()
        def reaches_work_ceiling(_):
            self.now = 180
        with self.assertRaises(ValueError):
            owner.select(frame, reaches_work_ceiling)
        self.assertTrue(owner.held)
        self.assertEqual(owner.completed, 0)

    def test_cancel_requires_timely_stop_and_observation(self):
        for requested, observed in ((None, 1), (41, 42), (40, 45)):
            with self.subTest(requested=requested, observed=observed):
                owner = self.owner(cancel=True)
                def worker(_):
                    if requested is not None:
                        self.now = requested
                        if requested == 41:
                            with self.assertRaises(ValueError):
                                owner.stop(owner.stop_capability)
                        else:
                            self.assertTrue(owner.stop(owner.stop_capability))
                    self.now = observed
                with self.assertRaises(ValueError):
                    owner.select(owner.reserve(), worker)
                self.assertEqual(owner.completed, 0)
                self.assertFalse(owner.close(owner.fixture_closure()))

    def test_malformed_closure_and_oversize_reference(self):
        owner = self.owner()
        for _ in range(4):
            owner.select(owner.reserve())
        self.assertFalse(owner.close({**owner.fixture_closure(), 'worker_exit': 1}))
        owner = self.owner()
        owner.reserve()
        with self.assertRaises(ValueError):
            owner.select(b'x' * 8193)
        self.assertTrue(owner.held)


if __name__=='__main__':
    unittest.main()
