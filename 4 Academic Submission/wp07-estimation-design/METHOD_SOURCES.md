# Method source checks and epistemic limits
Read-only checks: 8 November 2026. Targeted statistical-method review, not a new
full Zotero/NotebookLM or complete literature review. No library, manuscript
bibliography or references to legislation/news/benchmarking are changed.

| Source | Inspected support | Limits |
| --- | --- | --- |
| StataCorp, logit manual, https://www.stata.com/manuals/rlogit.pdf | Syntax/options; perfect-prediction examples; stored results including e(sample), e(rules), e(V), convergence and rank | Current manual does not certify runtime parity or project estimator validity. Perfect-predictor handling may remove observations; that is not authorized sample adoption |
| StataCorp, margins manual, https://www.stata.com/manuals/rmargins.pdf | at() endpoints, averaging remaining covariates as observed, delta VCE conditional on given covariates, estimability/error and matrix records | Proposed endpoint choices are project recommendations, not Stata recommendations; no native parse/test was performed |
| StataCorp, margins pwcompare manual, https://www.stata.com/manuals/rmarginspwcompare.pdf | Pairwise probability differences; r(b_vs), r(V_vs), r(table_vs), r(error_vs), r(L) alongside margins matrices | Future code must verify endpoint/difference orientation by labels/at/L rather than assume a matrix column order; no post option needed |
| StataCorp, test manual, https://www.stata.com/manuals/rtest.pdf | Coefficient-null Wald tests distinct from finite-contrast Wald tests | Wald validity depends on the fitted model and adopted covariance; six-slot policy comes from the accepted owner account |
| Abadie et al., author manuscript v4, https://arxiv.org/pdf/1710.02926 | Introduction/design discussion distinguishes clustering motivations from a generic geographic default; v4 dated September 2022 | The paper's specific sampling/treatment framework is not this nonprobability snowball survey; no theorem is transplanted as a proof that robust errors are adequate here. OUP/NBER endpoints failed retrieval; arXiv PDF identity/selected sections inspected, not every appendix |
| Goeman and Solari, https://arxiv.org/html/1211.3313v1 | Section3 gives Holm's sequential critical values and dependence on valid elementary tests | Missing-slot conservative implementation is a stated project derivation, artificially checked; not presented as a direct quotation or empirical result |
| Holm, https://www.jstor.org/stable/4615733 | Retained accepted article identity and previous citation ledger | Stable/PDF requests returned a tag-manager stub. No fresh full-text reading or publisher metadata verification beyond the retained ledger is claimed |
| Kosmidis and Firth, https://arxiv.org/abs/1812.01938 | Author abstract: finiteness of Jeffreys-prior penalized binomial-regression estimates and shrinkage/inference considerations | Abstract only in this pass; not software qualification, proof for a rank-deficient design, or an adopted estimator |

No web prose is quoted verbatim. The singleton-indicator argument and the
specific grouping/contrast recommendations are project inferences, not claims
that any external author analysed this cohort. The grouping choices deliberately
use source category meaning and existing marginal support, not fitted effects,
significance or unseen outcome cross-tabulations.

## Working reference entries
Abadie, A., Athey, S., Imbens, G. W., & Wooldridge, J. M. (2022).
*When should you adjust standard errors for clustering?* (Author manuscript,
arXiv:1710.02926v4). https://arxiv.org/abs/1710.02926
Use the verified final journal entry when updating the actual manuscript; this
package cites the retrieved manuscript rather than pretending to retrieve OUP.

Goeman, J. J., & Solari, A. (2010). The sequential rejection principle of familywise
error control. *The Annals of Statistics, 38*(6), 3782–3810.
https://doi.org/10.1214/10-AOS829

Holm, S. (1979). A simple sequentially rejective multiple test procedure.
*Scandinavian Journal of Statistics, 6*(2), 65–70.
https://www.jstor.org/stable/4615733
Identity retained from prior ledger and independently concordant Goeman/Solari
reference; original full text unavailable in this check.

Kosmidis, I., & Firth, D. (2020). *Jeffreys-prior penalty, finiteness and shrinkage
in binomial-response generalized linear models* (Author manuscript,
arXiv:1812.01938v4). https://arxiv.org/abs/1812.01938

StataCorp. (n.d.). *logit; margins; margins, pwcompare; test* [Reference-manual
entries, individually linked above]. Retrieved November 8, 2026.

