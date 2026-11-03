import hashlib
import tempfile
import unittest
from pathlib import Path
from types import ModuleType, SimpleNamespace
from unittest.mock import Mock, patch

from private_channel import Channel
from python_bootstrap import initialize_with_return, verify_config


class ReadinessTests(unittest.TestCase):
    def test_exit_before_or_during_frame_read(self):
        for role in ('watchdog', 'worker'):
            for states in ([True], [False, True]):
                with self.subTest(role=role, states=states):
                    wire = SimpleNamespace(kernel=SimpleNamespace(now=lambda: 10),
                                           read=Mock(return_value={'ready': True}))
                    with self.assertRaisesRegex(RuntimeError, 'exited'):
                        Channel.wait(wire, role, 'ready', 0, 60,
                                     role_exited=Mock(side_effect=states))
                    self.assertEqual(wire.read.call_count, len(states) - 1)

    def test_live_frame_and_late_frame(self):
        for role in ('watchdog', 'worker'):
            for times in ([10, 11], [10, 60]):
                frame = {'ready': True}
                wire = SimpleNamespace(kernel=SimpleNamespace(now=Mock(side_effect=times)),
                                       read=Mock(return_value=frame))
                if times[-1] == 60:
                    with self.assertRaises(TimeoutError):
                        Channel.wait(wire, role, 'ready', 0, 60, role_exited=lambda: False)
                else:
                    self.assertIs(Channel.wait(wire, role, 'ready', 0, 60,
                                               role_exited=lambda: False), frame)


class ReturnTests(unittest.TestCase):
    def test_exact_source_pin_and_function_ownership(self):
        with tempfile.TemporaryDirectory(prefix='wp06_config_fixture_') as root:
            path = Path(root) / 'utilities/pystata/config.py'
            path.parent.mkdir(parents=True)
            raw = b'def init(): pass\ndef _init_stata(): pass\ndef _get_executable_path(): pass\n'
            path.write_bytes(raw)
            config = ModuleType('artificial_config')
            config.__file__ = str(path)
            exec(compile(raw, str(path), 'exec'), vars(config))
            binding = dict(stata_home=root, runtime_identity_files={'pystata_config': [
                dict(path=str(path.resolve()), bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())]})
            verify_config(binding, config)
            with patch.object(config, '_init_stata', lambda: None), self.assertRaises(ValueError):
                verify_config(binding, config)
            path.write_bytes(raw + b'# changed')
            with self.assertRaises(ValueError):
                verify_config(binding, config)

    def test_forwarding_and_restoration(self):
        for rc in (0, -7100, -1):
            resolver = Mock(return_value=str(Path(__file__)))
            native = Mock(side_effect=lambda splash: (config._get_executable_path(), rc)[1])
            config = SimpleNamespace(_get_executable_path=resolver, _init_stata=native)
            config.init = lambda edition, splash: config._init_stata(splash)
            with patch('python_bootstrap.verify_config'), patch('python_bootstrap.record') as write:
                self.assertEqual(initialize_with_return({}, config), rc)
            native.assert_called_once_with(False)
            resolver.assert_called_once_with()
            self.assertIs(config._init_stata, native)
            self.assertIs(config._get_executable_path, resolver)
            self.assertEqual(write.call_args.args[2]['return_code'], rc)

    def test_primary_and_publication_errors_are_both_retained(self):
        failure = RuntimeError('original vendor failure')
        publication = OSError('artificial record failure')
        native = Mock(side_effect=failure)
        resolver = Mock()
        config = SimpleNamespace(_get_executable_path=resolver, _init_stata=native)
        config.init = lambda edition, splash: config._init_stata(splash)
        with patch('python_bootstrap.verify_config'), patch('python_bootstrap.record', side_effect=publication):
            with self.assertRaises(BaseExceptionGroup) as caught:
                initialize_with_return({}, config)
        self.assertEqual(caught.exception.exceptions, (failure, publication))
        self.assertIs(config._init_stata, native)
        self.assertIs(config._get_executable_path, resolver)

    def test_return_is_published_before_vendor_post_init_work(self):
        resolver = Mock(return_value=str(Path(__file__)))
        native = Mock(side_effect=lambda splash: (config._get_executable_path(), -7100)[1])
        config = SimpleNamespace(_get_executable_path=resolver, _init_stata=native)
        downstream = RuntimeError('artificial post-return SFI failure')
        with patch('python_bootstrap.verify_config'), patch('python_bootstrap.record') as write:
            def init(edition, splash):
                self.assertEqual(config._init_stata(splash), -7100)
                self.assertEqual(write.call_args.args[2]['return_code'], -7100)
                self.assertIs(config._get_executable_path, resolver)
                raise downstream
            config.init = init
            with self.assertRaises(RuntimeError) as caught:
                initialize_with_return({}, config)
            self.assertIs(caught.exception, downstream)
            write.assert_called_once()
            self.assertIs(config._init_stata, native)
