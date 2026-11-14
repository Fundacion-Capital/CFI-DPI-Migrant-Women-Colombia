"""Artificial-only adapter behavior and owned-thread fixtures; no engine or service."""
import copy
import importlib.util
import math
import pathlib
import threading
import unittest

PATH=pathlib.Path(__file__).with_name('adapter.py')

def binding():
    return dict(origin='ARTIFICIAL_ONLY',session_id='ART_session',owner_nonce='ART_nonce',worker_epoch=1,
        command_id='ART_command',pid=101,creation_time='ART_creation',engine_module_digest='ART_'+'a'*64,reservation_id='ART_reservation')

class Clock:
    def __init__(self):self.value=100.0
    def __call__(self):return self.value

class Channel:
    """Consumption-time ownership check in artificial transport, not a live backend."""
    def __init__(self,clock,current):
        self.clock=clock;self.current=copy.deepcopy(current);self.lock=threading.Lock()
        self.event=threading.Event();self.count=0;self.exited=False;self.gate=None
        spec=importlib.util.spec_from_file_location('delivery_policy',PATH)
        module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module);self.gate_type=module.DeliveryGate
    def deliver(self,intent):
        with self.lock:
            if self.exited:return None
            try:
                if self.gate is None:self.gate=self.gate_type(intent)
                authorized=self.gate.consume(intent,self.current,self.clock())
            except ValueError:return None
            if authorized is None:return None
            self.count+=1;self.event.set()
            return dict(kind='ART_EVENT_SET',binding=copy.deepcopy(self.current),observed_at=self.clock())

class AdapterTests(unittest.TestCase):
    def setUp(self):
        self.assertTrue(PATH.exists(),'Expected RED: isolated adapter not implemented')
        spec=importlib.util.spec_from_file_location('isolated_adapter',PATH)
        self.m=importlib.util.module_from_spec(spec);spec.loader.exec_module(self.m)
        self.b=binding();self.clock=Clock();self.book=self.m.ReservationBook()
        self.c=self.new();self.channel=Channel(self.clock,self.b)
    def new(self,**kwargs):
        return self.m.BoundControl(self.b,clock=self.clock,reservations=self.book,execution_budget=10,cleanup_budget=3,**kwargs)
    def start(self):self.c.start(self.b)
    def receipts(self,at=101):
        return [dict(kind=k,binding=copy.deepcopy(self.b),observed_at=at) for k in ('ART_EXIT_CONFIRMED','ART_CLEANUP_COMPLETE')]
    def test_full_artificial_binding_rejects_each_missing_extra_real_and_bad_type(self):
        for key in self.b:
            bad=copy.deepcopy(self.b);del bad[key]
            with self.subTest(missing=key),self.assertRaises(ValueError):self.m.BoundControl(bad,clock=self.clock,reservations=self.m.ReservationBook(),execution_budget=10,cleanup_budget=3)
        for patch in ({'origin':'REAL'},{'session_id':'default'},{'pid':True},{'worker_epoch':0},{'owner_nonce':''},{'creation_time':'actual'},{'engine_module_digest':'actual'},{'extra':'ART_extra'}):
            with self.subTest(patch=patch),self.assertRaises(ValueError):self.m.BoundControl(dict(self.b,**patch),clock=self.clock,reservations=self.m.ReservationBook(),execution_budget=10,cleanup_budget=3)
    def test_reservation_and_command_cannot_be_reused(self):
        with self.assertRaises(ValueError):self.new()
        other=dict(self.b,reservation_id='ART_other')
        with self.assertRaises(ValueError):self.m.BoundControl(other,clock=self.clock,reservations=self.book,execution_budget=10,cleanup_budget=3)
    def test_binding_and_snapshot_are_defensive_copies(self):
        self.b['pid']=999;self.c.start(binding())
        got=self.c.snapshot();got['binding']['pid']=777
        self.assertEqual(self.c.snapshot()['binding']['pid'],101)
    def test_mismatched_current_identity_never_emits_stop(self):
        self.start()
        for key,value in [('session_id','ART_other'),('owner_nonce','ART_old'),('worker_epoch',2),('command_id','ART_old'),('pid',102),('creation_time','ART_new'),('engine_module_digest','ART_b'),('reservation_id','ART_old')]:
            book=self.m.ReservationBook();c=self.m.BoundControl(self.b,clock=self.clock,reservations=book,execution_budget=10,cleanup_budget=3);c.start(self.b)
            with self.subTest(key=key),self.assertRaises(ValueError):c.cancel(dict(self.b,**{key:value}))
            self.assertEqual(c.snapshot()['stop_intents'],0);self.assertEqual(c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_cancel_before_start_consumes_without_signal(self):
        self.assertIsNone(self.c.cancel(self.b));self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
        with self.assertRaises(ValueError):self.c.start(self.b)
        self.assertEqual(self.c.snapshot()['stop_intents'],0)
    def test_cancel_emits_once_and_duplicate_does_not_retry(self):
        self.start();intent=self.c.cancel(self.b)
        self.assertEqual(intent['binding'],binding());self.assertEqual(intent['deliver_by'],103)
        self.assertIsNone(self.c.cancel(self.b));self.assertEqual(self.c.snapshot()['stop_intents'],1)
    def test_late_duplicate_cancel_closes_expired_cleanup_slot(self):
        self.start();self.c.cancel(self.b);self.clock.value=103
        self.assertIsNone(self.c.cancel(self.b))
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED');self.assertEqual(self.c.snapshot()['stop_intents'],1)
    def test_huge_receipt_time_fails_closed_as_validation_error(self):
        self.start();self.c.cancel(self.b)
        receipt=dict(kind='ART_EVENT_SET',binding=self.b,observed_at=10**1000)
        with self.assertRaises(ValueError):self.c.delivery(receipt,current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_exact_execution_deadline_emits_one_stop(self):
        self.start();self.clock.value=109.999;self.assertIsNone(self.c.tick(self.b))
        self.clock.value=110;self.assertIsNotNone(self.c.tick(self.b));self.assertEqual(self.c.snapshot()['state'],'STOP_REQUESTED')
        self.assertIsNone(self.c.tick(self.b))
    def test_expired_reserved_slot_cannot_start(self):
        self.clock.value=110
        with self.assertRaises(ValueError):self.c.start(self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_exact_cleanup_deadline_quarantines_late_response(self):
        self.start();intent=self.c.cancel(self.b);self.clock.value=113
        self.assertIsNone(self.channel.deliver(intent));self.assertIsNone(self.c.tick(self.b))
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
        with self.assertRaises(ValueError):self.c.complete(*self.receipts(),current=self.b)
    def test_legacy_ack_and_wrong_receipt_never_count_as_delivery(self):
        self.start();self.c.cancel(self.b)
        with self.assertRaises(ValueError):self.c.delivery(dict(status='stop_requested'),current=self.b)
        self.assertFalse(self.c.snapshot()['delivery_confirmed']);self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_confirmed_artificial_delivery_is_not_completion(self):
        self.start();receipt=self.channel.deliver(self.c.cancel(self.b));self.c.delivery(receipt,current=self.b)
        self.assertTrue(self.c.snapshot()['delivery_confirmed']);self.assertEqual(self.c.snapshot()['state'],'STOP_REQUESTED')
    def test_natural_completion_needs_exit_and_cleanup_receipts(self):
        self.start();self.clock.value=101;self.c.complete(*self.receipts(),current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'EXIT_CONFIRMED');self.assertIsNone(self.c.cancel(self.b))
        with self.assertRaises(ValueError):self.c.start(self.b)
    def test_cancelled_completion_requires_delivery_and_ordered_receipts(self):
        self.start();self.c.delivery(self.channel.deliver(self.c.cancel(self.b)),current=self.b)
        self.clock.value=101;self.c.complete(*self.receipts(),current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'EXIT_CONFIRMED')
    def test_exit_without_delivery_after_cancel_is_quarantined(self):
        self.start();self.c.cancel(self.b);self.clock.value=101
        with self.assertRaises(ValueError):self.c.complete(*self.receipts(),current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_future_or_reversed_receipts_never_confirm_exit(self):
        self.start();self.clock.value=101;exit,clean=self.receipts(102)
        with self.assertRaises(ValueError):self.c.complete(exit,clean,current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_cleanup_before_exit_and_missing_cleanup_are_rejected(self):
        for reverse in (True,False):
            c=self.m.BoundControl(self.b,clock=self.clock,reservations=self.m.ReservationBook(),execution_budget=10,cleanup_budget=3)
            c.start(self.b);self.clock.value=102
            exit,clean=self.receipts(102)
            if reverse:clean['observed_at']=101
            else:clean={'kind':'ART_CLEANUP_COMPLETE'}
            with self.subTest(reverse=reverse),self.assertRaises(ValueError):c.complete(exit,clean,current=self.b)
            self.assertEqual(c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_lost_ack_cannot_be_inferred_from_artificial_event(self):
        self.start();intent=self.c.cancel(self.b);self.channel.deliver(intent)
        self.assertTrue(self.channel.event.is_set());self.assertFalse(self.c.snapshot()['delivery_confirmed'])
        self.clock.value=103;self.c.tick(self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED');self.assertEqual(self.channel.count,1)
    def test_cancelled_slot_does_not_adopt_late_success(self):
        self.start();self.c.cancel(self.b);self.c.controller_lost();self.clock.value=101
        with self.assertRaises(ValueError):self.c.complete(*self.receipts(),current=self.b)
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_clock_rollback_and_nonfinite_fail_closed(self):
        for value in (99,math.inf,math.nan,True):
            clock=Clock();c=self.m.BoundControl(binding(),clock=clock,reservations=self.m.ReservationBook(),execution_budget=10,cleanup_budget=3);c.start(binding());clock.value=value
            with self.subTest(value=value),self.assertRaises(ValueError):c.tick(binding())
            self.assertEqual(c.snapshot()['state'],'UNKNOWN_QUARANTINED')
    def test_invalid_budgets_cannot_reserve(self):
        for value in (0,-1,math.inf,math.nan,True,'10'):
            with self.subTest(value=value),self.assertRaises(ValueError):self.m.BoundControl(binding(),clock=Clock(),reservations=self.m.ReservationBook(),execution_budget=value,cleanup_budget=3)
    def test_worker_replacement_rejects_queued_old_intent(self):
        self.start();intent=self.c.cancel(self.b)
        with self.channel.lock:self.channel.current=dict(self.b,worker_epoch=2,pid=102)
        self.assertIsNone(self.channel.deliver(intent));self.assertEqual(self.channel.count,0)
        with self.assertRaises(ValueError):self.c.tick(self.channel.current)
    def test_consumption_gate_rechecks_clock_binding_and_immutable_intent(self):
        self.assertTrue(hasattr(self.m,'DeliveryGate'),'Expected RED: consumption policy must live in real adapter')
        self.start();intent=self.c.cancel(self.b);gate=self.m.DeliveryGate(intent)
        for now in (99,103,math.nan,math.inf,10**1000,True):
            with self.subTest(now=now),self.assertRaises(ValueError):self.m.DeliveryGate(intent).consume(intent,self.b,now)
        forged=copy.deepcopy(intent);forged['deliver_by']=999
        with self.assertRaises(ValueError):self.m.DeliveryGate(intent).consume(forged,self.b,100)
        with self.assertRaises(ValueError):self.m.DeliveryGate(intent).consume(intent,dict(self.b,worker_epoch=2),100)
        authorized=gate.consume(intent,self.b,100)
        self.assertEqual(authorized['kind'],'ART_DELIVERY_AUTHORIZED')
        self.assertIsNone(gate.consume(intent,self.b,100))
    def test_expired_delivery_gate_cannot_reopen_after_clock_rollback(self):
        self.start();intent=self.c.cancel(self.b);gate=self.m.DeliveryGate(intent)
        with self.assertRaises(ValueError):gate.consume(intent,self.b,103)
        with self.assertRaises(ValueError):gate.consume(intent,self.b,100)
        self.assertFalse(self.channel.event.is_set())
    def test_extreme_finite_cancel_returns_bounded_intent_atomically(self):
        clock=Clock();clock.value=1e308
        c=self.m.BoundControl(self.b,clock=clock,reservations=self.m.ReservationBook(),execution_budget=4e307,cleanup_budget=3e307)
        c.start(self.b);clock.value=1.6e308
        intent=c.cancel(self.b)
        self.assertTrue(math.isfinite(intent['deliver_by']));self.assertEqual(intent['deliver_by'],1.7e308)
        self.assertEqual(c.snapshot()['stop_intents'],1)
    def test_custom_equality_origin_cannot_enter_immutable_binding(self):
        class PretendOrigin:
            def __eq__(self,other):return True
        bad=dict(self.b,origin=PretendOrigin())
        with self.assertRaises(ValueError):self.m.BoundControl(bad,clock=self.clock,reservations=self.m.ReservationBook(),execution_budget=10,cleanup_budget=3)
    def test_custom_equality_kind_cannot_certify_delivery(self):
        class PretendKind:
            def __eq__(self,other):return True
        self.start();self.c.cancel(self.b)
        with self.assertRaises(ValueError):self.c.delivery(dict(kind=PretendKind(),binding=self.b,observed_at=100),current=self.b)
        self.assertFalse(self.c.snapshot()['delivery_confirmed'])
    def test_delayed_duplicate_or_exited_channel_cannot_signal(self):
        self.start();intent=self.c.cancel(self.b)
        self.assertIsNotNone(self.channel.deliver(intent));self.assertIsNone(self.channel.deliver(intent));self.assertEqual(self.channel.count,1)
        self.channel=Channel(self.clock,self.b);self.channel.exited=True
        self.assertIsNone(self.channel.deliver(intent))
    def test_controller_loss_quarantines_without_retry(self):
        self.start();self.c.controller_lost();self.assertIsNone(self.c.cancel(self.b))
        self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED');self.assertEqual(self.c.snapshot()['stop_intents'],0)
    def test_concurrent_cancel_race_emits_one_intent(self):
        self.start();barrier=threading.Barrier(9);out=[];errors=[]
        def run():
            try:barrier.wait(timeout=2);out.append(self.c.cancel(self.b))
            except Exception as exc:errors.append(repr(exc))
        workers=[threading.Thread(target=run) for _ in range(8)]
        try:
            for t in workers:t.start()
            barrier.wait(timeout=2)
        finally:
            for t in workers:t.join(3)
        self.assertFalse(errors);self.assertTrue(all(not t.is_alive() for t in workers))
        self.assertEqual(sum(x is not None for x in out),1);self.assertEqual(self.c.snapshot()['stop_intents'],1)
    def test_independent_artificial_controller_reaches_blocked_work(self):
        self.start();started=threading.Event();release=threading.Event();controlled=threading.Event();errors=[]
        def work():started.set();release.wait(3)
        def supervise():
            try:
                if not started.wait(2):raise RuntimeError('Artificial work missing')
                self.clock.value=110;intent=self.c.tick(self.b)
                self.c.delivery(self.channel.deliver(intent),current=self.b);controlled.set()
            except Exception as exc:errors.append(repr(exc));controlled.set()
        worker=threading.Thread(target=work);controller=threading.Thread(target=supervise)
        try:
            worker.start();controller.start();self.assertTrue(controlled.wait(2));self.assertFalse(errors)
            self.assertTrue(worker.is_alive());self.assertTrue(self.channel.event.is_set())
            self.assertEqual(self.c.snapshot()['state'],'STOP_REQUESTED')
            self.clock.value=113;self.c.tick(self.b);self.assertEqual(self.c.snapshot()['state'],'UNKNOWN_QUARANTINED')
        finally:
            release.set();worker.join(3);controller.join(3)
        self.assertFalse(worker.is_alive() or controller.is_alive())

if __name__=='__main__':unittest.main(verbosity=2)
