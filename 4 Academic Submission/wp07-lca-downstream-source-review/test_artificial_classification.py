"""Pure artificial arithmetic illustrating historical classification rules, not Stata."""
import unittest


def historical_assignment(probabilities):
    return probabilities.index(max(probabilities)) + 1


def historical_second_distinct(probabilities):
    maximum = max(probabilities)
    below = [p for p in probabilities if p < maximum]
    return max(below) if below else None


class ArtificialClassificationChecks(unittest.TestCase):
    def test_unique_maximum_mapping_preserves_assignment(self):
        raw = [0.10, 0.20, 0.15, 0.55]
        mapping = {1: 1, 4: 2, 3: 3, 2: 4}
        reordered = [raw[0], raw[3], raw[2], raw[1]]
        self.assertEqual(mapping[historical_assignment(raw)], 2)
        self.assertEqual(historical_assignment(reordered), 2)

    def test_exact_tie_priority_can_change_after_relabeling(self):
        raw = [0.10, 0.40, 0.10, 0.40]
        mapping = {1: 1, 4: 2, 3: 3, 2: 4}
        reordered = [raw[0], raw[3], raw[2], raw[1]]
        self.assertAlmostEqual(sum(raw), 1.0)
        self.assertEqual(mapping[historical_assignment(raw)], 4)
        self.assertEqual(historical_assignment(reordered), 2)
        self.assertNotEqual(mapping[historical_assignment(raw)], historical_assignment(reordered))

    def test_second_distinct_is_not_second_order_statistic_under_tie(self):
        raw = [0.40, 0.40, 0.10, 0.10]
        self.assertEqual(historical_second_distinct(raw), 0.10)
        self.assertEqual(sorted(raw, reverse=True)[1], 0.40)
        self.assertAlmostEqual(max(raw) - historical_second_distinct(raw), 0.30)
        self.assertEqual(max(raw) - sorted(raw, reverse=True)[1], 0.0)

    def test_all_equal_probabilities_have_no_strictly_lower_second(self):
        raw = [0.25, 0.25, 0.25, 0.25]
        self.assertIsNone(historical_second_distinct(raw))
        self.assertEqual(sorted(raw, reverse=True)[1], 0.25)

    def test_no_tie_second_values_agree(self):
        raw = [0.10, 0.20, 0.15, 0.55]
        self.assertEqual(historical_second_distinct(raw), sorted(raw, reverse=True)[1])

    def test_missing_metrics_can_pass_legacy_ge_reporting_screen(self):
        # Artificial comparison model only: Stata numeric missings exceed all finite numbers.
        missing = float("inf")
        legacy_flag = (1 == 1 and 4 in (4, 5) and missing >= 5 and missing >= 0.60)
        self.assertTrue(legacy_flag)
        self.assertFalse(all(value != missing for value in (missing, missing)))


if __name__ == "__main__":
    unittest.main(verbosity=2)
