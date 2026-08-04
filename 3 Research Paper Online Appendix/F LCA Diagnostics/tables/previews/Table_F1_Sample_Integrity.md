# Sample integrity

This is a display-only Markdown rendering of [the authoritative Excel workbook](../Table_F1_Sample_Integrity.xlsx). The workbook remains the source file for download and replication.

## Sheet: sample_integrity

| section | check | definition | count | percent | status | notes |
| --- | --- | --- | --- | --- | --- | --- |
| Data intake | Loaded dataset | Dataset successfully loaded from coded analysis path or fallback path | 423 | 100 | OK | Configured coded analytical dataset; see the project setup and data availability documentation. |
| Sample size | Total observations | Number of rows in the final coded analytical dataset | 423 | 100 | OK | Expected analytical N = 423 |
| Sample definition | Final analysis sample | Dataset treated as the already-cleaned eligible/completed analysis sample | 423 | 100 | OK | Eligibility, consent, and completion filters are assumed to have been applied upstream in data preparation. |
| Identifier | Nonmissing ID observations | Observations with nonmissing KEY if available; otherwise fallback lca_id | 423 | 100 | OK | KEY uniquely identifies observations. |
| Identifier | Duplicated ID observations | Number of observations involved in duplicated nonmissing KEY values | 0 | 0 | OK | Final ID used in the LCA workflow: KEY |
| Candidate variables | Candidate index variables available | Number of expected candidate index variables found in the dataset | 15 |  | OK | Missing candidate indices: |
| Candidate variables | Nonmissing candidate indices | Observations nonmissing across all available candidate indices | 423 | 100 | OK | Candidate indices are diagnostic only; final LCA inputs will be selected after distribution and redundancy checks. |
| Preliminary LCA inputs | Core input variables available | Number of preliminary core LCA input variables found in the dataset | 11 |  | OK | Missing preliminary core inputs: |
| Preliminary LCA inputs | Nonmissing core LCA inputs | Observations nonmissing across all available preliminary core LCA inputs | 423 | 100 | OK | This is the main starting sample for diagnostic LCA input selection. |
| Expanded LCA inputs | Expanded input variables available | Number of expanded LCA input variables found in the dataset | 15 |  | OK | Missing expanded inputs: |
| Expanded LCA inputs | Nonmissing expanded LCA inputs | Observations nonmissing across all available expanded LCA inputs | 423 | 100 | OK | Expanded model may be used later as a sensitivity or richer segmentation specification. |
