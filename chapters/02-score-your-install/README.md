# Chapter 2: Score your install

Fifteen minutes, and one row decides it.

![Six releases on a ladder of state schema versions: 2026.8.1, 2026.8.2, 2026.9.1 and 2026.9.2 all at schema 15 with a live rollback arrow running back through them, and 2026.9.3 at schema 16 and 2026.9.4 at schema 17 beyond a door that opens only one way, where the rollback arrow stops](../../images/one-way-door.png)

**What you build:** `go-no-go.md`, holding a target version, six scored rows, a total, a band, and one
sentence naming the row that dominated.

**Fill in first: the gate row**, worth six on its own:

```bash
cp <your-state-db> /tmp/oc-shape-check.sqlite
openclaw database preflight /tmp/oc-shape-check.sqlite --json
```

Your current release should answer `exact`. If your **own** release says anything else, stop
scoring and go to chapter 6: you have a problem that predates this upgrade.

That `cp` is fine for reading a shape and is **not** a backup. The gateway is writing while you
copy, and raw copies of a live database can be torn. Chapter 4 has the one you can restore from.

**Success:** six rows each traceable to a command or a checkable fact. Read the dominant-row
sentence out loud; if it sounds like a guess, go measure that row.

**On your install:** the target's opinion is the one that matters and your current release can't
give it to you. Chapter 4 gets it from the target's own binary. Then come back and replace the
guess in the gate row with a measurement.
