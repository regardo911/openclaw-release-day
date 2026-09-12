<!-- memory-entry.template.md (Chapter 7). One entry per cycle. Copy this; do not fill it in here. -->

# Memory entry template

Five fields. Keep them short and keep them the same shape, because the value is in finding them
later.

Field two is the one people get lazy about and it is the most valuable. Six months from now you
won't remember what happened. You will remember an error message, and you will paste it into a
search box. Make sure that box is your own memory store.

```markdown
## <one line: what broke, and on what move>

**Broke:** <one line, plain>

**String:** <the exact string, copied, not paraphrased. The field you will search on.>

**Fixed by:** <the command, exactly as run>
(<and the reasoning beside it — what you tried first that did not work, and why the thing
that worked, worked. The command alone saves future-you no time.>)

**Default that moved:** <from the chapter 8 sweep, or none this cycle>

**Before:** openclaw <version> · state schema <n> · node <version>
**After:**  openclaw <version> · state schema <n> · node <version>
**One-way:** <yes or no. If the schema moved, the snapshot before this is the only way back.>

**Cost:** <minutes, and where they went>
```

One entry with a number on it is trivia. Five is a trend line, and the trend line is the whole
argument.

**Cycle-one diagnosis time:**
**Cycle-three diagnosis time, same failure:**

_Both blank until you measure them._

---

## The commands this is built on

```bash
openclaw memory rem-harness      # preview what would be promoted. Writes nothing.
openclaw memory session-backfill # distil retained session history into staged candidates
openclaw memory promote          # rank the candidates, write nothing
openclaw memory promote --apply  # the flag that appends
```

`session-backfill` is a **dry run by default** and prints `Dry run; use --apply to stage
candidates.` Read that before you believe you staged anything.

`promote` bare is the review; `--apply` is the write. Look at the first before you run the second.

To remove one bad memory rather than wiping everything: `openclaw memory forget` takes **no
positional argument**. `memory forget <entry>` answers `Too many arguments for this command.` and
exits 1. Scope it with `--session`, `--participant`, `--hook-source` or `--since`, and run
`--dry-run` first, every time.
