<!-- recovery-runbook.md (Chapter 6). Readable by a version of you who is annoyed, at night, with the gateway down. -->

# recovery-runbook.md

No prose. No explanation. Phase, symptom, command, expected, fix.

Column one takes a phase from `failure-phases.md`, or a dash where the symptom has no phase of its
own. That column keeps this useful after the error strings are rewritten.

Nine seed rows. Add your own from `findings.md`, and fill in **your** paths.

| Phase | What you see | Command that confirms it | Expected | Fix |
|---|---|---|---|---|
| - | anything is wrong | `openclaw status` · `gateway status` · `doctor` · `logs --follow` | one says something surprising | start at that level. **Do not restart first** |
| `doctor-failed` `repairing` | repair errors and names repair | run once more, compare the blocker text | different = progress, identical = stop | different: keep going, write each down. identical: rollback row, now |
| - | about to install an older version | `rollback-gate.sh <copy> <older-binary>` | `exact` to proceed | not `exact`: restore the snapshot, or go forward to a release that can repair |
| - | gateway exits or loops | `openclaw logs --follow` | one identifiable first error, not a wall | keyed to that error |
| - | `EADDRINUSE` | check what holds the port | nothing should | usually your old gateway, still running, because the stop did not stop |
| `plugin-target-unavailable` `post-update-plugins` | will not converge | `openclaw plugins list` vs inventory §6 | the same plugins | name the missing or drifted one. A removed bundled plugin: `OPENCLAW_EXTENSIONS`. A drifted one can be the right version and inert, waiting on a capability consent nobody gave |
| - | nothing erroring, something wrong | `gateway probe` vs baseline · `df -h` · `oom-check.sh <container>` | same ballpark as baseline | keyed to which moved. Distrust zeroes: nothing-found on an install you know has things is looking in the wrong place |
| - | job did not deliver, gateway fine | your own completion signal | the report you scheduled | deliver by hand tonight |
| - | out of ideas | `openclaw triage` · `gateway diagnostics export` | a bundle you can attach | hand over a structured report instead of a description. Last on purpose |

---

**Your paths**

| What | Where, on your box |
|---|---|
| state database | |
| config file | |
| log location | |
| stop command | |
| snapshot repository | |

---

**Tested against a failure I caused on purpose:** _date, and which one._

Point a newer release at a schema-15 copy and try to start it. Then recover using only this file.
Anything you had to look up is a missing row, and finding it is the value of the exercise.
