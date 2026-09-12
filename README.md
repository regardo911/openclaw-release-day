# openclaw-release-day

**Turn an OpenClaw release from an improvised emergency into a written, rehearsed, scheduled
procedure, and keep the install earning and capped while it runs unattended.**

The blank runbooks, scored sheets and status gates from *Build an OpenClaw 2.0 Pipeline That Works
While You Sleep*. More at [youcanbuildthings.com](https://youcanbuildthings.com).

![The ten stages of the release-day pipeline laid out as a loop (Inventory, Rehearse, Update, Verify and recover, Preserve, Audit, Relocate, Earn, Cap, Repeat), each labelled with the artifact it produces and tagged with when it fires: weekly, daily, on release day, or on your word only. A separate maintainer agent sits below, held one release behind the primary inside the same schema generation.](images/pipeline-map.png)

In plain terms: OpenClaw runs on your own machine and ships new versions constantly, and upgrade
day is where people lose an afternoon. This is the paperwork for that day: empty forms you fill in
with facts about your own install, plus short scripts that check the risky things before you commit
to them. Two words you'll hit immediately. A **gate** is a five-line script that asks one question and
stops you when the answer is wrong. A **schema** is the version number of the database your agent's
memory lives in. Above a certain release, it only moves forward. Start with the first command
below.

## Start here

**I run OpenClaw and I want to know what I actually have.** The fastest path, and the one I'd
recommend by name. Runs chapter 3's read-only commands against your install and writes their real
output into the nine-section inventory every other chapter reads from.

```bash
./collect-inventory.sh
```

**A release just shipped and I want to know whether it's safe for me.** Stand the target up in a
throwaway prefix, then ask *it* about a copy of your data. The second argument is the point: your
current release always says `exact`.

```bash
TMP=$(mktemp -d)
npm install --prefix "$TMP" --ignore-scripts openclaw@<your-target-version>
cp <your-state-db> /tmp/oc-shape-check.sqlite
./chapters/04-rehearse-on-a-copy/preflight-gate.sh /tmp/oc-shape-check.sqlite "$TMP"/node_modules/.bin/openclaw
```

**Something is broken right now.** [chapters/06-recovery-runbook](chapters/06-recovery-runbook/),
and read the first ninety seconds before you restart anything.

**I finished the book and I want my own copies.** The copy table is next.

## Copy table

Copy each into your own private repository and fill it in there. It stays private: it holds your
configuration, and configuration on this product touches credentials.

| Chapter | File here | Where it goes |
|---|---|---|
| 2 | [`go-no-go.md`](chapters/02-score-your-install/go-no-go.md) | the front of your repo. The routine re-enters on it |
| 3 | [`install-inventory.md`](chapters/03-install-inventory/install-inventory.md) | your repo, filled by `./collect-inventory.sh` |
| 4 | [`findings.md`](chapters/04-rehearse-on-a-copy/findings.md) | one numbered list per rehearsal |
| 5 | [`runbook-card.md`](chapters/05-the-runbook-card/runbook-card.md) | printed, or on your phone |
| 6 | [`recovery-runbook.md`](chapters/06-recovery-runbook/recovery-runbook.md) | somewhere you can read it with the gateway down |
| 6 | [`failure-phases.md`](chapters/06-recovery-runbook/failure-phases.md) | beside it. Your rows key to these |
| 7 | [`automations.md`](chapters/07-preserve-and-compound/automations.md) | the repo from `openclaw backup git init` |
| 7 | [`memory-entry.template.md`](chapters/07-preserve-and-compound/memory-entry.template.md) | copy per cycle into your memory store |
| 8 | [`settings-paths.txt`](chapters/08-pin-the-defaults/settings-paths.txt) | your repo. You append to it as releases add keys |
| 8 | [`settings-record.md`](chapters/08-pin-the-defaults/settings-record.md) | next to the audit output |
| 9 | [`box-build.md`](chapters/09-the-always-on-box/box-build.md) | your repo, so the second box costs twenty minutes |
| 9 | [`compose.example.yml`](chapters/09-the-always-on-box/compose.example.yml) | your repo, renamed, angle brackets filled |
| 10 | [`margin-sheet.md`](chapters/10-work-that-pays/margin-sheet.md) | updated per billing period |
| 11 | [`spend-sheet.md`](chapters/11-cap-the-bill/spend-sheet.md) | beside the margin sheet, monthly |
| 12 | [`stage-table.md`](chapters/12-the-standing-routine/stage-table.md) · [`schedule.md`](chapters/12-the-standing-routine/schedule.md) · [`re-entry.md`](chapters/12-the-standing-routine/re-entry.md) | your repo, and the schedule into `openclaw cron` |

## Chapter map

| Chapter | What you build | Command | Success |
|---|---|---|---|
| [2](chapters/02-score-your-install/) | a scored go/no-go | fill it in | a dominant-row sentence that doesn't sound like a guess |
| [3](chapters/03-install-inventory/) | the nine-section inventory | `./collect-inventory.sh` · `./node-floor.sh` | close the terminal, still answer five questions |
| [4](chapters/04-rehearse-on-a-copy/) | a restore you performed, and your findings | `./preflight-gate.sh` · `./rehearsal-round-trip.sh` | the copy reaches the target, or fails in a way you can name |
| [5](chapters/05-the-runbook-card/) | the one-page card | fill it in | a time next to every step, in your own handwriting |
| [6](chapters/06-recovery-runbook/) | the five-column recovery table | `./rollback-gate.sh` | you induced a failure and recovered using only the file |
| [7](chapters/07-preserve-and-compound/) | the why beside the what | fill it in | you restored a deleted automation and could tell it was working |
| [8](chapters/08-pin-the-defaults/) | five authored settings | `./record-before.sh` · `./prove-authored.sh` · `./audit-remediations.sh` | unset one, watch the sweep fail with the path named |
| [9](chapters/09-the-always-on-box/) | the nine-step box build | `./oom-check.sh` | you rebooted it, touched nothing, a real message got a real reply |
| [10](chapters/10-work-that-pays/) | one priced job and the margin sheet | fill it in | revenue per run and cost per run, without opening a terminal |
| [11](chapters/11-cap-the-bill/) | the trip-wire and the spend sheet | `./tripwire.sh <ceiling>` | you forced it to fire and your chosen degrade happened |
| [12](chapters/12-the-standing-routine/) | the schedule and the maintainer | fill it in | the whole routine ran from cold without improvisation |

Chapter 1 has no folder. It's the book's only chapter without a build step.

## What it needs to run

**Your own OpenClaw install.** Every `openclaw …` command runs against it. That's the book's
premise rather than a gap: you own the product, and most of this repo is the paper the book has you
fill in.

**`jq` and `timeout`**, which OpenClaw does not ship. A minimal Linux box has no `jq` and macOS has
no `timeout`. Install both before you rely on any gate, or one fails on a missing binary instead of
on a schema and you'll read that as a pass.

**A POSIX shell**, and that is the whole list: no package manifest, no lockfile, no build system,
no language runtime to install.

`./node-floor.sh` and `tests/run-tests.sh` run bare, with no key, no account, no network and no OpenClaw.
[`tests/`](tests/) proves the gates branch the right way against the strings the product emits.

## Contributing

Fixes welcome: a gate that takes the wrong branch, a command that has changed, a broken link. See
[CONTRIBUTING.md](CONTRIBUTING.md). New artifacts are out of scope, because this repo mirrors the
book's fourteen and a fifteenth would leave readers hunting for a chapter that doesn't exist.

MIT licensed. See [LICENSE](LICENSE).

---

Educational material for learning and research. Not financial, security or legal advice. Read
[DISCLAIMER.md](DISCLAIMER.md) before you act on any of it.
