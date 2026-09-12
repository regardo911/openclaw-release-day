<!-- go-no-go.md (Chapter 2). Score the upgrade before you run it. -->

# go-no-go.md

**Target version:** _an actual version string, not "latest". Check what is on offer with
`npm view openclaw dist-tags` and `openclaw update status --json`._

## The gate row

Nothing else here is worth six.

```bash
cp <your-state-db> /tmp/oc-shape-check.sqlite
openclaw database preflight /tmp/oc-shape-check.sqlite --json
```

Your current release says `exact`. The opinion you need belongs to the **target**, and chapter 4
gets it from the target's own binary. Until then, score the side of the boundary it sits on:
2026.9.2 and below target schema 15, 2026.9.3 targets 16, 2026.9.4 targets 17.

| Verdict | Score | Yours |
|---|---|---|
| `exact` | 0 | |
| `migration-required` | 6 | |

## The five rows, 0 to 3 each

| Row | How to measure it | 0 | 1 | 2 | 3 | Yours |
|---|---|---|---|---|---|---|
| Releases behind | `openclaw update status --json` | current or 1 | 2 to 3 | 4 to 8 | more, or lost count | |
| Config surface | size of the file from `openclaw config file` | default, untouched | a few keys | tens of keys | hundreds, or any `plugins.entries.codex.*` | |
| Headless | do you run `doctor` with no terminal attached | never | rarely | usually over ssh | ssh only, or an agent runs it | |
| Agents and automations | `openclaw agents list` · `cron list` | 1 agent, few crons | 1 agent, many crons | 2 to 3 agents | a fleet, or others depend on it | |
| Second update surface | do you also run the desktop app | CLI only | installed, unused | both in daily use | both, different versions | |

**Total:**

## The verdict

**0 to 4.** Low risk, take the update. Still snapshot first: chapter 4 takes twenty minutes and an
unrestored backup is not a backup.

**5 to 9.** Rehearse first. Chapter 4 against a copy, then chapter 5 on the real thing. Expect to
find two or three things.

**10 or more.** Rehearse, and consider a nearer target. If the gate row scored 6, ask whether a
release below the boundary gets you most of what you wanted without the one-way door.

**Your band:**

## The row that dominated, in one sentence

_If you cannot name it you have not scored honestly, and if it sounds like a guess when you read it
out loud, go back and measure that row._

## Two questions for a release tracker

A tracker verdict is not a fact anybody can print, including this repo: it was different last week
and will be different next week. These two don't expire.

1. How many credible blocking issues does this release carry right now, and are any in a phase my
   install actually goes through?
2. How long has it been in the field? A release nobody has run has no known issues, which is not
   the same as having none.

**Answers:**
