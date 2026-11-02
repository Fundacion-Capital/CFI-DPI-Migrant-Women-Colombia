# Official technical sources — verified 2 November 2026

These are primary documentation sources, not evidence that a mechanism worked on this host. Installed vendor/provider bytes and saved trial records govern host-specific statements. Current web documentation is not a hash-pinned copy of the installed Python 3.11.15 implementation.

- [Stata 19 PyStata configuration](https://www.stata.com/python/pystata19/install.html): documents utilities-path configuration followed by `config.init`; distinguishes optional package needs for run-only versus data exchange. It does not identify this trial's discovery failure.
- [Stata 19 config API](https://www.stata.com/python/pystata19/config.html): documents `init` and the public initialized-state check. The additional distinction between Stata and SFI flags comes from the exact installed config.py, not an assertion that the public flag suffices here.
- [Stata PyStata integration manual](https://www.stata.com/manuals/ppystataintegration.pdf): documents executable selection and `python query` metadata, including library path. No such Stata query was executed in this diagnosis. No persistent configuration change is proposed.
- [Python 3.11 DLL-directory documentation](https://docs.python.org/3.11/library/os.html#os.add_dll_directory): describes loader-directory scope for imported extension dependencies and ctypes. It does not promise that an unrelated native discovery algorithm uses that scope.
- [Python sysconfig documentation](https://docs.python.org/3.11/library/sysconfig.html): documents configuration-variable lookup, including missing values. Matching strings in the Stata binary do not prove which lookup ran or what it returned.
- [uv Python-version documentation](https://docs.astral.sh/uv/concepts/python-versions/#minor-version-directories): describes Windows minor-version junctions and portable managed distributions. This supports interpreting the saved raw/resolved path difference, not blaming the alias or assuming registry state on this machine.

No forum, secondary search result or unverified compatibility anecdote is used as a technical authority. No documentation instruction to install packages, alter environment variables or contact support was executed.
