<!-- stage-table.md (Chapter 12). Ten stages, twelve artifacts, every one traceable to its chapter. -->

# The stage table

| Stage | Artifact | From |
|---|---|---|
| Inventory | `install-inventory.md` | Ch3 |
| Rehearse | the status gate on a copy, and `go-no-go.md` with its top row now measured | Ch4, Ch2 |
| Update | the runbook card | Ch5 |
| Verify and recover | `recovery-runbook.md` | Ch6 |
| Preserve | `backup git create --all --push` plus the memory write | Ch7 |
| Audit | the `valid but unset` sweep | Ch8 |
| Relocate | the supervised box and its `gateway probe` baseline | Ch9 |
| Earn | the scheduled job and the margin sheet | Ch10 |
| Cap | the trip-wire and the spend sheet | Ch11 |
| Repeat | the assembled schedule and the maintainer agent | Ch12 |

That traceability is not tidiness. It is what lets you fix one stage without working out all the
others again.

---

## The two agents

Same schema generation, different release. Check the pair before every release-day run.

| | Primary | Maintainer |
|---|---|---|
| Version | | |
| State schema | | |

Release day, in three lines:

1. Check the target's schema with `preflight-gate.sh` on a copy.
2. Schema-neutral target: upgrade the primary, leave the maintainer. You have free skew.
3. Target crosses a boundary: the maintainer moves **first**.

**One writer.** The maintainer reads the primary's state, checks it, snapshots it and reports. It
does not write while the primary is running. If it needs to act on state, the primary is stopped
first: step 4 of your card, and the same discipline you already follow by hand.

Ownership settings are a place where a plausible-looking configuration puts you in a restart loop.
Change them on the copy first.
