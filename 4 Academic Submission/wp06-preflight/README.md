# WP06 artificial-only preflight

These scripts contain no estimation command, participant-input loader or saved-model reader. They test mathematics and metadata only. They cannot activate the twelve proposed fit recipes or approve sample, rights, measurement or reporting decisions.

Run Stata code only through the Stata MCP connection in a **new, uniquely named, owned empty session**, never default/shared. The scripts assert zero observations/variables rather than clearing unknown state. Set a new empty artificial output directory outside any previous packet. Preserve previous outputs; native capture uses exclusive `fopen(...,"w")` and refuses existing files.

Use MCP selections to run `math_functions.do`, then `math_assertions.do` with the new output directory as its sole argument, then `matching_assertions.do`. Pass absolute paths appropriate to the checkout. The first helper must load successfully before assertions; a separator or MCP `isError=false` is not a successful mathematical receipt. Require the full four-class-count marker sets and final zero-return guard in an explicit Stata log. The capture files have an ARTIFICIAL_WP06 origin and ART-prefixed coordinates; they are not observed gsem output.

Afterward confirm no observations, variables or estimation state; discard only the owned fixture session through MCP session management and verify its absence. Do not clear, destroy or inspect the shared default session's data. Never treat connector timeout as interruption or permission to advance. The present synthetic sleep test established eventual cleanup, **not prompt independent cancellation of an active fit**.

The JSON checkpoint has nine pending gates. The fifteen construct prompts require explicit dated researcher decisions, not a blanket inferred approval. All empirical membership checks, institutional approvals and scientific adoption remain outside these scripts. Python metadata/controller checks and exact private receipts remain in the ignored preservation packet, not a public replication-data release.
