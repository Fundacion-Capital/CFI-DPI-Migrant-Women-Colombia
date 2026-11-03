# Stata style-only review copy, v1

The three scripts in this folder are annotated copies of the historical source at `3c51c36`. **Review copies only; do not run them under this approval.** They still contain the original paths and file-writing commands; this folder does not redirect or sandbox those commands.

| Script | Reading guide |
| --- | --- |
| 0 Master | Historical session, user paths and package setup. The legacy child calls remain commented out. |
| 1 Data Preparation | Historical workbook intake, audit carrier, exclusions, measurement construction and coded saves. The name of the second save does not certify redaction. |
| 2 Analysis | Stage-specific input carriers, descriptives, historical regressions and interactions, candidate and preferred-final LCA, saved-segment profiles and overlays, and report exports. |

All additions are standalone `* [Style v1]` comments. Nothing in the historical command stream was edited, moved, activated, or removed. This pass intentionally does not correct the master path branch, harmonize carriers, implement academic decisions, or alter scripts to make them runnable.

Removing only the added comment lines, including their own line endings, reproduces each historical file byte for byte. The original mixed line endings, indentation, comments, macro quoting, delimiters and continuations are preserved.

| Script | Added lines | Historical SHA-256 | Review SHA-256 |
| --- | ---: | --- | --- |
| Master | 5 | `d2ec519440281bfd0316ec9cd7de1bdf64afadff5e7959e43a774f33323c7b39` | `6cc48708952e1ccdbcf51920d5e77a8bf01642dc720644a9f9ab6d3a0366e0d9` |
| Data Preparation | 9 | `e6a9e542dcff1067dcda7a37a19b5cff542b65b54622f198c240a419dc0ed449` | `b004a263e6593d3e83dab7e3d5d3a8ff381ccf53a8ef757ba11dcdf5fa5ea252` |
| Analysis | 20 | `714377ca31de2b6d70db0994e3c7ef6a38374165d7b1fb7c7abeb3b3f56549c9` | `5483ae5cdba059ecf868b89270aeb125da5920a2fd0965885095cd355e76a2bb` |

This is source preservation, not a Stata run or numerical equivalence test. Do not release this folder without a separate disclosure review: it preserves historical source literals, paths and output commands. No participant dataset was opened and no output was regenerated.
