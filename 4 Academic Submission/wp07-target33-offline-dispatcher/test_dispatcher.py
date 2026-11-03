"""Only in-memory fixture traffic. No empirical paths or real transport."""
from dataclasses import replace
from pathlib import Path
import unittest

import dispatcher as d


class DispatcherTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.plan=d.load_plan(Path(__file__).resolve().parent.parent)

    def simulate(self, **kw):
        fake=d.ArtificialTransport(self.plan,**kw)
        result=d.dispatch(self.plan,fake)
        return fake,result

    def test_exact_four_steps_and_one_simulated_load(self):
        fake,result=self.simulate()
        self.assertEqual(fake.calls,['P1','P2','P3','P4'])
        self.assertEqual(result['status'],'ARTIFICIAL_PASS')
        self.assertEqual(result['simulated_loads'],1)
        self.assertEqual(result['actual_loads'],0)
        self.assertEqual(len(result['check_dispositions']),33)
        self.assertEqual(fake.cleanup_calls,1)
        self.assertEqual(fake.cancel_calls,0)

    def test_late_step_is_not_accepted_and_never_retried(self):
        fake,result=self.simulate(durations=(1,45,1,1))
        self.assertEqual(fake.calls,['P1','P2'])
        self.assertEqual(result['status'],'TECHNICAL_STOP')
        self.assertEqual(result['check_dispositions']['P2.01'],'technical_stop')
        self.assertEqual(result['check_dispositions']['P3.01'],'not_executed')
        self.assertEqual(fake.cancel_calls,1)
        self.assertEqual(fake.cleanup_calls,1)

    def test_unverified_closure_quarantines_entire_packet(self):
        fake,result=self.simulate(cleanup_ok=False)
        self.assertEqual(fake.calls,['P1','P2','P3','P4'])
        self.assertEqual(result['status'],'QUARANTINED')
        self.assertFalse(result['cleanup_verified'])

    def test_late_cleanup_quarantines(self):
        _,result=self.simulate(cleanup_duration=30)
        self.assertEqual(result['status'],'QUARANTINED')

    def test_missing_row_and_unapproved_content_stop_dispatch(self):
        for fault in ('missing_row','raw_value','foreign_scope','wrong_digest','nonaggregate_log','extra_output','count_not_reconciled'):
            with self.subTest(fault=fault):
                fake,result=self.simulate(fault=fault)
                self.assertEqual(fake.calls,['P1','P2'])
                self.assertEqual(result['status'],'TECHNICAL_STOP')
                self.assertEqual(fake.cancel_calls,1)

    def test_failed_independent_cancel_quarantines(self):
        _,result=self.simulate(fault='wrong_digest',cancel_ok=False)
        self.assertEqual(result['status'],'QUARANTINED')

    def test_reuse_and_foreign_transport_rejected_before_dispatch(self):
        fake,_=self.simulate()
        with self.assertRaises(ValueError):
            d.dispatch(self.plan,fake)
        with self.assertRaises(ValueError):
            d.dispatch(self.plan,object())

    def test_source_mutation_rejected_before_reservation(self):
        for sha in (self.plan.steps[0].sha256,d.digest(b'fake')):
            mutated=replace(self.plan,steps=(replace(self.plan.steps[0],body=b'fake',sha256=sha),*self.plan.steps[1:]))
            fake=d.ArtificialTransport(mutated)
            with self.assertRaises(ValueError):
                d.dispatch(mutated,fake)
            self.assertFalse(fake.calls)

    def test_modified_output_templates_rejected_before_reservation(self):
        mutated=replace(self.plan,steps=(replace(self.plan.steps[0],outputs=()),*self.plan.steps[1:]))
        fake=d.ArtificialTransport(mutated)
        with self.assertRaises(ValueError):
            d.dispatch(mutated,fake)
        self.assertFalse(fake.calls)

    def test_no_overrun_when_late_at_last_step(self):
        fake,result=self.simulate(durations=(44,44,44,45))
        self.assertEqual(fake.calls,['P1','P2','P3','P4'])
        self.assertEqual(result['status'],'TECHNICAL_STOP')
        self.assertEqual(result['check_dispositions']['P4.08'],'technical_stop')
        self.assertEqual(fake.cleanup_calls,1)

    def test_preflight_never_provisions_output_root(self):
        self.assertFalse(self.plan.output_root.exists())
        self.assertFalse(self.plan.live_enabled)


if __name__=='__main__':
    unittest.main()
