# Determinants exhibits

These are Stata-generated, aggregate-only exhibit candidates for *Digital
Payments, Partial Inclusion: Evidence from Migrant Women in Colombia*.
Keep the main results prose descriptive; point readers to the complete
numeric roster in the technical supplement. No file here includes individual
records, enrollment keys, fine cell totals, or the restricted run logs.

| Deliverable | Files |
|---|---|
| Model roles, fitted samples, focal coefficients, and fixed-six Wald tests | `det_models.tex`, `det_coefficients.tex`, `det_wald.tex` |
| Complete roster and support flags | `det_contrasts_core.tex`, `det_contrasts_checks.tex`, `det_contrasts.csv` |
| Vector figures for the supplement | `det_contrasts_core.pdf`, `det_contrasts_all.pdf`, with `det_figure_note.tex` under the caption |
| Annotated seminar/conference figures | `det_contrasts_core_slides.png` for the two core models; `det_contrasts_all_slides.png` for backup |

Include the table fragments with `\input` and `booktabs`, and the PDFs with
`\includegraphics` and `graphicx`. The note is a paragraph, not a caption;
put it under the figure caption within the float. For example, when the TeX
build starts at the repository root:

```latex
\input{2 Output/Academic/Determinants/det_contrasts_core.tex}
\begin{figure}[tbp]
  \centering
  \includegraphics[width=\linewidth]{2 Output/Academic/Determinants/det_contrasts_all.pdf}
  \caption{Associations with reported digital participation}
  \label{fig:determinants-all}
  \par\smallskip\footnotesize\raggedright
  \input{2 Output/Academic/Determinants/det_figure_note.tex}
\end{figure}
```

If the compiler starts inside `Working paper/` or `Presentation/`, adjust
the paths with `../`. Use one plot where a plot is needed; the all-model
plot is the complete companion to the two tables. Open symbols denote
limited exact endpoint support on the education-by-residence screen, not
statistical insignificance. No public release or slide deck is implied by
these local files.

Rebuild with [3 Determinants exhibits.do](../../../1%20Code/academic/3%20Determinants%20exhibits.do)
using verified ledgers in a restricted folder. See the
[code README](../../../1%20Code/academic/README.md) for the commands.
The full coefficient table contains rare-category terms and remains
restricted. Copy only the named display files here.
