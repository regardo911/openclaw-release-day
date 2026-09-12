<!-- runbook-card.md (Chapter 5). One page. The version of this procedure that works on YOUR box. -->

# Runbook card

Printed, or in a file you can open on a phone while the laptop is busy. Every step has a command
**and** the exact output you should see, because a step with no expected output is a step you
cannot verify.

The timing column stays blank until you run it. Nobody can tell you how long this takes on your box
with your data, and that is the one number on this card you cannot borrow.

| # | Step | Command | Expect | Your time |
|---|---|---|---|---|
| 0 | Read the card | from `go-no-go.md` and `install-inventory.md` | target version, schema verdict, install root, Node version. Any of the four blank and you are not starting today | |
| 1 | Preflight a copy | `cp <state-db> /tmp/pre-upgrade.sqlite` then `preflight-gate.sh /tmp/pre-upgrade.sqlite <target-binary>` | `exact` or `migration-required`. A fact you write down, not a pass or a fail. Never chain it with `&&`: both exit 0 | |
| 2 | Snapshot | `openclaw backup sqlite create --global --repository <dir> --json` | `"ok": true`, a manifest with `userVersion` and `sha256`, a few seconds, gateway still up. **If it hangs** you typed `backup create` | |
| 3 | Verify the snapshot | `openclaw backup sqlite list --repository <dir>` then `verify <snapshot> --json` | exit 0, matching sha256. `verify` takes a positional path and rejects `--repository` | |
| 4 | Stop the gateway | _yours_ | a subsequent `gateway probe` that fails to connect. A gateway you thought you stopped and did not is how you get a torn database | |
| 5 | Update | `openclaw update --tag <target>` | progress, possibly long silences, up to thirty minutes of designed patience. **Do not kill it** | |
| 6 | Let it migrate | start the gateway | your rehearsal's restart count, plus or minus one | |
| 7 | Verify | `openclaw --version` · `gateway probe` · `agents list` · `cron list` | the target version; a probe matching your baseline **including the app version on the last line**; counts matching your inventory | |
| 8 | Channels | message each one | a reply on each | |
| 9 | Stop here today | - | `openclaw update cleanup` is not part of this run. It destroys your rollback path. Calendar it a week out | |

**Your stop command (step 4):**

**Your update command (step 5).** If your package manager came back `unknown`, drive the update
through it directly rather than through OpenClaw's own path:

**Restart cycles your rehearsal saw (step 6):**

---

## If ssh is the only way you reach this box

`doctor --fix`, `doctor --fix --force` and `doctor --repair --non-interactive` silently skip their
work with no terminal attached. They run, they exit, they do not do the thing.

- `ssh -t`, or `ssh -tt` when the command is non-interactive. Cheapest fix by a mile.
- `tmux` or `screen` on the box. You also get to detach without killing a thirty-minute update.
- `--accept-capabilities` and `--yes` on the update, for the two places a headless run stalls for a
  legitimate reason. Neither fixes the silent skip.
- Stop the **supervisor**, not just the gateway. One that restarts a gateway mid-migration turns a
  recoverable failure into a loop, then into suppressed channels, then into an evening.

**Which I use:**
