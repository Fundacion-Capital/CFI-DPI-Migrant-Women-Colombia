# Quantitative Online Appendix

This directory is the public, aggregate-output appendix for the quantitative component of *Digital bridges for financial inclusion: DPI in migrant women empowerment in Colombia*.

The package documents the analysis exactly as it is currently implemented. It does not revise any index, regression, interaction, latent class model, posterior assignment, class label, or substantive estimate.

## Contents

| Appendix | Directory | Contents |
|---|---|---|
| A | `A Research Instrument/` | Printable quantitative survey instrument |
| C | `C Variable Construction/` | Current index architecture and item mapping; index summary statistics, correlation matrix, distribution plots, and correlation heatmap |
| D | `D Descriptive Evidence/` | Extended categorical and multiple-response tables plus all established descriptive figures |
| E | `E Multivariate Regressions/` | Existing regression, interaction, and supplementary-item tables and figures |
| F | `F LCA Diagnostics/` | Existing sample, indicator, recoding, model-selection, fit, classification-certainty, robustness, response-pattern, and class-profile diagnostics |
| G | `G Segment Profiles/` | Existing class mapping, segment size/certainty, conditional-response, centroid, demographic, financial-behavior, risk/autonomy, outcome, multinomial, and policy-typology outputs |

Each analytical appendix separates `tables/` and `figures/`. File names begin with the appendix letter where a stable publication label is required. The original descriptive and diagnostic file names are retained where they already encode the analytical workflow.

## Reproduction workflow

1. Configure the repository globals and run the established data-preparation and analysis workflow in Stata.
2. Run Section 18, `ONLINE APPENDIX EXPORTS`, in `1 Code/2 Analysis_CFI DPI Migrant Women Colombia.do`.
3. Build the integrated manuscript with:

   ```text
   python "3 Research Paper Online Appendix/code/build_quantitative_appendices.py" --source "PATH/TO/manuscript.docx" --output "PATH/TO/manuscript - Quantitative Appendices Integrated.docx"
   ```

Section 18 copies the frozen publication outputs and creates only the aggregate Appendix C and D tables that require Stata. `Table_C0_Current_Index_Architecture.xlsx` is an editorial documentation table assembled from the current data-preparation code; it is intentionally not a new statistical estimation step.

The Word builder inserts Appendices C-G before the existing qualitative appendices, embeds the appendix tables and figures, applies consistent captions and table formatting, and writes `appendix_manifest.csv` with SHA-256 checksums for the public appendix files.

## Public-release boundary

The appendix contains aggregate tables, figures, model summaries, and the research instrument only. It intentionally excludes respondent-level datasets, record-level predictions, direct identifiers, temporary files, and analysis logs.

## Files that should not be edited manually

Stata-generated CSV files, copied regression/LCA outputs, figures, and `appendix_manifest.csv` should be regenerated from the code. The integrated Word manuscript should be rebuilt with `code/build_quantitative_appendices.py` after any appendix-output change.
