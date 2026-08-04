# Quantitative online appendix

This directory is the public quantitative supplement to *Digital bridges for financial inclusion: DPI in migrant women empowerment in Colombia*. The manuscript retains only a short appendix roadmap; the complete quantitative exhibits are stored here.

The package documents the analysis exactly as implemented. It does not revise any index, regression, interaction, latent class model, posterior assignment, class label, or substantive estimate.

## Browse the appendix

| Appendix | Online materials | Contents |
|---|---|---|
| Appendix A.1 | [Quantitative research instrument](A%20Research%20Instrument/README.md) | The complete quantitative survey questionnaire administered through SurveyCTO/CATI, retained as a printable HTML instrument. |
| Appendix C | [Quantitative variable construction and index architecture](C%20Variable%20Construction/README.md) | Index definitions, item-to-index mapping, summary statistics, correlations, and distribution diagnostics. |
| Appendix D | [Quantitative descriptive evidence](D%20Descriptive%20Evidence/README.md) | Extended descriptive tables and the full set of established descriptive figures. |
| Appendix E | [Multivariate regression analysis](E%20Multivariate%20Regressions/README.md) | Complete regression tables, average marginal effects, coefficient plots, and interaction figures. |
| Appendix F | [Latent class analysis diagnostics and model selection](F%20LCA%20Diagnostics/README.md) | Sample checks, recoding rules, feature sets, model selection, fit statistics, response patterns, and classification diagnostics. |
| Appendix G | [Final LCA segment profiles and post-LCA validation](G%20Segment%20Profiles/README.md) | Class labels, segment profiles, posterior certainty, multinomial models, outcome validation, and policy typology outputs. |

Each analytical directory contains a formatted table index, GitHub-readable table previews, a complete figure gallery, and the original downloadable source files.

## Reproduction boundary

- Tables and figures that report quantitative data, models, marginal effects, interactions, LCA diagnostics, or segment validation are produced by [the Stata analysis do-file](../1%20Code/2%20Analysis_CFI%20DPI%20Migrant%20Women%20Colombia.do). Section 18 packages the aggregate outputs into these stable appendix directories.
- The quantitative questionnaire and the current index-architecture workbook are static documentation artifacts. They are maintained manually because they describe the instrument and implemented scoring rules rather than report newly estimated results.
- Markdown previews and directory READMEs are presentation mirrors for GitHub. The original CSV, TXT, XLSX, HTML, and PNG files remain authoritative.

## Public-release boundary

The online appendix contains only aggregate tables, figures, model summaries, and the research instrument. It excludes respondent-level datasets, record-level predictions, direct identifiers, temporary files, and analysis logs.

## File verification

- [Artifact manifest with file sizes and SHA-256 checksums](appendix_manifest.csv)
- [Artifact-level provenance and reproduction map](appendix_provenance.csv)
