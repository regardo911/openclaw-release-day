# Chapter 6: The recovery runbook

Written to be readable by a version of you who is annoyed, at night, with the gateway down.

**What you build:** `recovery-runbook.md`, with five columns and nine seed rows, keyed to the product's
own failure phases rather than to error strings, with your paths in it.

## The first ninety seconds

Orient. Four commands, each answering "how far did it get" at a different level:

```bash
openclaw status
openclaw gateway status
openclaw doctor
openclaw logs --follow
```

Move down until one says something surprising. That is your first stable error, and it is what you
read for, not every follow-on warning.

**Do not restart the gateway first.** It is the reflex this failure most reliably triggers and it
costs you twice: a restart buries the first error under a wall of startup messages, and it can
re-trip the breaker that suppresses your channels after enough failed boots.

Then the only diagnosis that matters early: **is each repair pass showing a different blocker, or
the identical one?** Different means the tool is peeling one layer per pass and it is working.
Identical means stop. Keep a count, on paper. If you cannot say whether the last two differed, you
are not debugging, you are hoping.

**The one command**, before you install an older version:

```bash
./rollback-gate.sh <copied-db> <older-openclaw-binary>   # do not roll back: migration-required
```

Both arguments are required and the second is the whole gate. Your database has been migrated
forward by the release that broke it, and an older binary sees a schema number from the future and
**refuses to open it**. So a rollback above the door turns a broken install into one that won't
start at all, and you did it while panicking.

When you cannot roll back, the recovery goes **up**. The migration content in a later release is
frequently what fixes a half-applied earlier one. And check `npm view openclaw dist-tags` first,
because the tag carrying the schema you need may be `beta`.

**Success:** you caused a failure on the disposable copy on purpose and recovered using **only**
this file. Every row you had to invent mid-recovery has been added. The easiest honest failure to
induce: point a newer release at a schema-15 database and try to start it.

**On your install:** `failure-phases.md` is the vendor's taxonomy, and that is the point of keying
rows to phases. Error text changes between releases; phase names are structural.
