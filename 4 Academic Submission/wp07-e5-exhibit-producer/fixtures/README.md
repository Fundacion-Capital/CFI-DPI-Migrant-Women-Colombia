# Artificial E.4-shaped aggregate fixture

These five CSVs are NOT study results, participants or a fitted model. Only the
published/pinned ledger schemas, identifiers and matrix dimensions are mirrored.
Every N, coefficient, covariance, probability, test p-value and support count is
artificial. No model or statistic was estimated to construct these test inputs.

Model Ns are deliberately 120/108/108/96/108 in R0/D0/R1/D1/R0C order, preventing
the producer from assuming that every model uses a common denominator. Fitted
coefficient positions mirror the source schema, including reference columns;
nonreference covariance diagonals are .04. Off-diagonals are zero except for
one symmetric pair set to 1.2345678901234567e-5 to test numeric round trips. The first
coefficient is .1; its covariance-derived SE must be .2 when tested in Stata.
Unused postestimation auxiliary cells contain artificial placeholders and are
not evidence of a coherent estimated latent/probability model.

The first difference has a -.004 lower bound, so two-decimal rendering must not
change its includes-zero label. Endpoint intervals deliberately include -.02
and 1.02; clipping is forbidden. Raw/Holm pairs are a hand-specified fixed-six
family, not newly computed p-values. CASES.json specifies two positive order/
boundary cases and ten negative input/output cases. Native tests are unrun.

Do not use these records as empirical findings or replace the restricted E.4
ledgers with them. Artificial output destinations must stay separate from real
restricted rendering destinations and from all preceding packets.
