# Stata coding standard for this academic revision

Recorded 25 October 2026 from the owner's explicit instructions during WP06–D2. **Project requirement, not a code change or an empirical verification.** Applies to future authorized work; no existing Stata file was edited or executed in this package. Human-reviewable style is the goal, not a claim to conceal AI assistance or a guarantee about authorship detectors. Actual assistance/disclosure requirements remain separate.

## 1. Researcher-readable code first

Write ordinary social-science research do-files, not a software framework. A reader should see the substantive operation, sample qualifier and reason where the command occurs.

- Prefer direct, explicit commands and named variable lists. Write distinct analytical steps separately, even when a clever abstraction would be shorter.
- Use purposeful comments throughout: each meaningful block and each non-obvious line documents the task, substantive coding rule, denominator, units/period, source question or exact exhibit. Explain why a recode/exclusion/threshold exists, not merely restate syntax. Do not pad every obvious line with boilerplate.
- Use a compact informative header: purpose, inputs, outputs, scope, relevant software/source version, authorship/edit history. Never fabricate a human author or date.
- Keep sections aligned to the research sequence and outputs, with clear whitespace and readable line lengths/continuations. Favor explicit command names; never use ambiguous variable abbreviations.
- Ordinary locals/globals for paths and a short shared control list are acceptable when they make meaning visible. Do not hide model specifications in layered macro indirection, dynamic dispatch or nested string construction.
- Avoid custom helpers, programs, Mata routines and nested loops for tasks that simple explicit Stata can express. A short plainly named loop is an exception only where the repeated task is genuinely identical and easier to audit; never introduce one solely to compress a few lines.
- Use exact existing variable/estimate/output names in a style-only pass. Renaming public interfaces or reorganizing execution order is not presumed harmless.
- No alternate-input fallback, silent latest-file search, retry ladder, invented failure-recovery layer or blanket capture. If a required source is absent or a condition fails, stop visibly rather than produce plausible results from something else.
- Preserve a few essential checks at trust boundaries, e.g. required identifier uniqueness, a justified merge outcome or a declared sample condition. Native assert/isid and normal Stata failures are preferable to verbose custom error machinery. Never suppress an analytical error to make a script finish.
- Do not add package installation, service configuration, process-control or runtime ownership machinery to the scientific do-files. Document required versions and keep necessary audit/execution tooling separate; do not remove protected infrastructure under a style instruction.
- Keep manual exclusions and their exact restricted provenance. Public-code privacy adaptation is a separate task; do not print embedded identifiers or delete exclusions as cosmetic cleanup.
- Comments must match actual behavior and units. Existing comments that promise demonstrated skills, national representation, identical routes or unperformed analyses must not be preserved as if true merely because they look human-written.

These are owner-directed project choices. They do not require adopting every convention in an external guide, nor copying arbitrary patterns from a published package.

## 2. Style-only work must be analytically inert

The owner requires exactly the same analytical output when only writing style changes. Before any authorized style pass, distinguish:

**Style-only:** comments, whitespace, transparent section organization and mechanically equivalent syntax, subject to verification. No sample, missing/sentinel behavior, storage type, precision, variable order, sort/RNG sequence, estimator option, contrast/reference category, weight, seed, starts, iteration setting, or output-content change.

**Scientific correction:** any change to eligibility, geography/time, scoring/direction, available-item denominators, transformations, normalization, inference or models. Such changes belong to the separately versioned academic-revision track and require the relevant explicit decision. Never call a correction a formatting change.

Even apparently cosmetic changes can alter macro expansion, scope, r()/e() results, sort order or numerical storage. Do not change them without a comparison. Replacing a short expression with a longer one is not evidence of equivalence.

When later participant/execution authority permits validation, compare the same protected inputs and runtime against the pre-style baseline: exact sample membership and order internally, generated values/types/missingness, model coefficients and covariance/sample/omission information, seeds/settings, and every reported number/table/figure. Preserve numerical targets; do not substitute rounded display matches for unrounded equality. Metadata or binary container timestamps can differ without an analytical difference; identify such nonanalytical differences rather than promise every PDF/log byte is identical.

For stochastic LCA, unchanged seed alone is not sufficient; preserve sorting, version/runtime and random-number call sequence and compare the appropriate native outputs. Do not rerun fits merely to validate style unless the exact bounded fits are separately authorized. If equivalence cannot be established, label it unverified and do not adopt the rewrite.

No such equivalence test or Stata execution occurred in WP06–D2.

## 3. Primary guidance actually reviewed

The [DIME Analytics Coding Guide](https://worldbank.github.io/dime-data-handbook/coding.html) treats readability as a substantive property: structure, familiar syntax and explanatory style. The reviewed sections cover comments, variable names, whitespace, loops, paths, conditional expressions and settings. This supports a consistent project style; it does not require our project to use its helper commands or every example.

[J-PAL's data-cleaning and management guidance](https://www.povertyactionlab.org/resource/data-cleaning-and-management) supports organized sections and comments explaining decisions, kept consistent with code. Its examples include some practices we will not transplant mechanically, such as path fallbacks. Readability guidance is not authority to change our survey's sentinels.

[J-PAL's publishing guide, code section pp.9–10](https://www.povertyactionlab.org/sites/default/files/research-resources/J-PAL-guide-to-publishing-research-data.pdf) emphasizes reproducible scripts, useful headers, documented construction and recognizable outputs. Removing unnecessary publication files means selecting a release package, not deleting protected historical originals.

[J-PAL's coding-resources page](https://www.povertyactionlab.org/resource/coding-resources-randomized-evaluations) points to replication archives and examples, while explicitly noting that no collection is comprehensive. It is a discovery route, not a binding current journal policy.

Some online guide code/examples have inconsistencies or context-specific assumptions. They are not copy-ready replacements for our audited code. No textbook example establishes a missingness mechanism, validates our construct or certifies compatibility with historical Stata16 behavior.

## 4. Actual script-reading evidence and limits

- DIME handbook [master template](https://github.com/worldbank/dime-data-handbook/blob/main/code/box-2-4-stata-master-dofile.do):77lines read. Useful task/inputs/outputs annotations and direct stage calls; this is a teaching template, not an empirical journal replication.
- World Bank [Demand for Safe Spaces master](https://github.com/worldbank/rio-safe-space/blob/WP/Reproducibility%20Package/MASTER.do):lines1–170 read through GitHub MCP, blob87465788796262da1a6d284130a80974263235d0. Shows visible paths, shared controls and stage calls. Its package/installation logic is not adopted.
- Same working-paper package [paper-results master](https://github.com/worldbank/rio-safe-space/blob/WP/Reproducibility%20Package/dofiles/analysis/paper/MASTER_paper_results.do):lines1–160 read, blob6c00cc1730356cc7654e8bcf4deb86d3f38ec61e. Clear exhibit/input/output mapping; not a full review of underlying estimation scripts or proof of journal publication.

No third-party source code/data were downloaded to the repository, copied into our Stata code or executed. These examples motivate transparent structure; they do not demonstrate that every human researcher codes the same way.

## 5. Bibliography-linked and top-journal review remains incomplete

The Zotero MCP successfully enumerated39items in library1, collection26, CFI DPI Migrant Women Colombia. Metadata only—not39full texts and not39Stata packages. [The coverage register](wp06-d2-decision-package/coding_sources.json) retains all39item identities and unassessed package status.

One bibliography-linked lead is item696: the retained working-paper DOI10.3386/w34280 has a2026journal version verified on the [publisher page](https://link.springer.com/article/10.1057/s41308-026-00329-x), which links package10.3886/E251128V1. Package access was unavailable here; no code inspected and no Zotero record updated. AER's Jack–Suri2014 article/replication link was verified separately; openICPSR access403prevented script review. It is not claimed as a collection member or code exemplar.

DIME Wiki's targeted Stata page returned403. The official DIME handbook counterpart was reviewed instead; no authentication repair or website-wide crawl was performed. Several broad searches returned irrelevant results; none are used as technical evidence. The earlier incomplete Zotero calls are recorded as discovery errors, not evidence that the collection is absent.

**Therefore the requested exhaustive study of all DIME/J-PAL resources, top-journal packages and every bibliography-linked Stata package is NOT complete.** It needs a separate bounded corpus-by-corpus reading effort, beginning with the39-item package-availability/software census; do not hold D2 preparation open indefinitely or falsely claim exhaustive mastery. No continuing background run is scheduled.

## 6. Tool use and future reading

Use relevant skills and connected tools proportionately: Stata MCP for all analytical execution; Zotero for scoped bibliography identity/full texts when needed; public NotebookLM only for source discovery with original-source verification; official web/journal repositories for policies and examples; file tools for metadata/documents; independent review for substantive package closeout. Never invoke unrelated tools merely because installed, install suites without authority, or let a skill override project/privacy/scientific boundaries.

This durable project document, rather than a new system-memory entry, carries the requirement forward. The user did not authorize a memory-file update. Next authorized Stata work must read this standard before editing, identify whether its diff is style-only or scientific, and use the simplest explicit implementation with appropriate verification.
