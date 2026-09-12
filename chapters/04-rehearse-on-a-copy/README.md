# Chapter 4: Rehearse on a copy

The most valuable evening in the book. Your production gateway stays up throughout.

**What you build:** a restore you have actually performed end to end, and a numbered list of what
broke on your own data in the order it broke.

**The one command:**

```bash
./preflight-gate.sh <copied-db> <target-release-binary>
```

```
exact: that release opens this database without rewriting it
```

or `schema move ahead: migration-required` and exit 1.

**The second argument is the one people leave off**, and leaving it off makes the gate useless:
the answer you want belongs to the release you are about to install, not the one you are running.

```bash
TMP=$(mktemp -d)
npm install --prefix "$TMP" --ignore-scripts openclaw@<your-target-version>
./preflight-gate.sh <copied-db> "$TMP"/node_modules/.bin/openclaw
```

Use `npm install --prefix`, not the raw tarball: the tarball ships without its dependencies and
fails with `ERR_MODULE_NOT_FOUND: Cannot find package '@openclaw/fs-safe'`, which no error message
explains. Then redirect `OPENCLAW_STATE_DIR` and `OPENCLAW_CONFIG_PATH` when you run it — setting
both is the whole isolation story.

For the snapshot loop in one go:

```bash
./rehearsal-round-trip.sh <backup-repo-dir> <restore-target> <target-release-binary>
```

## Why the gate reads the status and never the exit code

`migration-required` **exits 0**, exactly as `exact` does. So this:

```bash
openclaw database preflight copy.sqlite && ./upgrade.sh    # WRONG
```

reads like a safety check and is not one. It passes on the precise case you built it to catch.
Exit 1 from that command means "I couldn't read this file". It never means "this upgrade is
unsafe".

The gate has no `2>&1`, unlike the chapter 8 sweep: if the file is unreadable you want the
product's own error on your terminal rather than swallowed into a pipe. It exits 1 either way.

## The other command that is generous with exit 0

The session-store half of the rehearsal has its own version of the same trap, and this one is
worse because there is nothing in the output to read:

```
$ openclaw doctor --session-sqlite inspect --session-sqlite-all-agents --non-interactive
session-sqlite inspect: 0 target(s), 0 legacy entries, 0 sqlite entries, 0 issue(s)
$ echo $?
0
```

That is what "nothing is wrong" looks like. It is also what "I looked in the wrong place" looks
like, and there is no way to tell which one you got. So when the copy comes back with zeroes
across the board, do not tick the box: check you pointed it at the right state directory. If your
live install has sessions and the copy reports zero, the interesting question is not "is the copy
clean", it is "did I actually copy the sessions".

`dry-run` and `inspect` are the two read-only modes and are safe against anything. And there is no
`--agent` flag on this command: `openclaw doctor --session-sqlite inspect --agent main` answers
`OpenClaw does not recognize option "--agent".` and exits 1. Per-agent scoping is spelled
`--session-sqlite-agent <id>`, with `--session-sqlite-store <path>` beside it. A rejected flag name
is not a missing capability.

**Success:** the copy reaches the target version, **or** it fails in a way you can name and have
written down. Both pass. What does not pass is a rehearsal you abandoned halfway.

**On your install:** you need `jq` and `timeout` first. Neither is part of OpenClaw, a minimal
Linux box has no `jq` and macOS has no `timeout`, and a gate that fails on a missing binary rather
than on a schema is one you will read as a pass.

And know this before it costs you an hour: **`openclaw backup create` hangs with the gateway
running.** Zero output, no archive, exit 124 under `timeout 60`, and a partial
`.openclaw-backup-publish-<uuid>` directory left behind. Its `--dry-run` returns instantly and
looks healthy because it never exercises the part that hangs. `openclaw backup sqlite create` is a
different command and finishes in seconds.
