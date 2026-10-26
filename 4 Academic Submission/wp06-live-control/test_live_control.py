"""Default tests are pure guards; real launches require the separate approved suite."""
import copy
import ctypes
import json
import unittest

import live_windows as win
from live_roles import encode, decode, before, identity_matches, validate_profile, Context, sources, PRIVATE, DOMAIN

KEY = b'unit-fixture-not-a-live-credential!'

class Guards(unittest.TestCase):
    def test_bootstrap_rejects_extra_input_and_extended_deadlines(self):
        class ClockOnly:
            frequency = 1000
            api = type('API', (), {'GetCurrentProcess': staticmethod(lambda: 7)})()
            def identity(self, handle): return {'pid': 7, 'birth': 100}
        packet = dict(domain=DOMAIN, run='a'*32, case='cooperative', packet=str(PRIVATE),
            sources=sources(), frequency=1000, origin=0, bootstrap=5000, control=8000,
            cleanup=10000, outer=12000, role='L', self_identity={'pid':7,'birth':100},
            keys={role:'01'*32 for role in 'LOSCW'}, caps={})
        Context(ClockOnly(), packet)
        bad = dict(packet, participant_file='FORBIDDEN.dta')
        with self.assertRaises(ValueError): Context(ClockOnly(), bad)
        bad = dict(packet, outer=200000)
        with self.assertRaises(ValueError): Context(ClockOnly(), bad)

    def test_authenticated_body_cannot_be_changed(self):
        wire = encode({'run': 'r', 'role': 'W', 'kind': 'BOOT', 'payload': {'pid': 7}}, KEY)
        self.assertEqual(decode(wire, KEY)['payload']['pid'], 7)
        bad = json.loads(wire)
        bad['payload']['pid'] = 8
        with self.assertRaises(ValueError): decode(json.dumps(bad).encode(), KEY)

    def test_wrong_role_key_and_duplicate_or_large_frames_reject(self):
        wire = encode({'run': 'r', 'role': 'W'}, KEY)
        with self.assertRaises(ValueError): decode(wire, b'wrong-role-key')
        with self.assertRaises(ValueError): decode(b'{"run":1,"run":2}', KEY)
        with self.assertRaises(ValueError): decode(b' ' * 8193, KEY)

    def test_deadline_equality_is_expired(self):
        before(10, 9)
        with self.assertRaises(ValueError): before(10, 10)
        with self.assertRaises(ValueError): before(10, 11)

    def test_pid_alone_is_not_an_identity(self):
        expected = {'pid': 7, 'birth': 100}
        identity_matches(expected, {'pid': 7, 'birth': 100})
        with self.assertRaises(ValueError): identity_matches(expected, {'pid': 7, 'birth': 101})
        with self.assertRaises(ValueError): identity_matches(expected, {'pid': 8, 'birth': 100})

    def test_profiles_do_not_accept_commands_inputs_or_foreign_targets(self):
        self.assertEqual(validate_profile('cooperative'), 'cooperative')
        for bad in ['stata', 'participant', 'cmd.exe', '../cooperative', '', None]:
            with self.assertRaises(ValueError): validate_profile(bad)

    def test_windows_layout_reuses_existing_abi_without_loading_a_dll(self):
        self.assertEqual(ctypes.sizeof(win.ExtendedLimits), 144)
        self.assertEqual(ctypes.sizeof(win.Accounting), 48)
        self.assertEqual(ctypes.sizeof(win.PROCESS_INFORMATION), 24)

if __name__ == '__main__':
    unittest.main()
