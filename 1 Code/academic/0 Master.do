/*-----------------------------------------------------------------------------
  Master do-file | Digital Payments, Partial Inclusion
  Jorge E. Zavala and Angélica Cardozo Cadavid
  Run one academic analysis stage on the approved data in memory. Stata 16.
-----------------------------------------------------------------------------*/
version 16
set more off
set varabbrev off

/* Contents
   1. Project paths
   2. Stata commands
   3. Analysis
*/

* 1. Project paths
* Pass descriptives or determinants, the repository, and a fresh restricted output folder.
args stage repository restricted_output extra
if !inlist("`stage'", "descriptives", "determinants") | ///
    "`repository'" == "" | "`restricted_output'" == "" | "`extra'" != "" {
    exit 198
}
local code "`repository'/1 Code/academic"

* 2. Stata commands
if "`stage'" == "descriptives" {
    capture findfile scheme-plotplain.scheme
    if _rc ssc install blindschemes
    set scheme plotplain
}
else {
    which logit
    which margins
}

* 3. Analysis
* Load the approved prepared fields before calling this file. The restricted
* preparation build and aggregate exhibit renderer are separate steps.
do "`code'/2 Analysis.do" "`stage'" "`restricted_output'" "`code'"

* Historical E.5, Appendix C2 and LCA are not dispatched from this master.

