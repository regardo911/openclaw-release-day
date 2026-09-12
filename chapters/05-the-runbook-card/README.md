# Chapter 5: The runbook card

One page. Ten steps. The version of this procedure that works on your box.

**What you build:** `runbook-card.md`, with a command and an exact expected output on every line,
and your own wall-clock time beside every step.

**Fill in first: step 4, your stop command.** It depends on how yours runs: a service manager, a
container, a foreground process. Nobody else can write that line, and it's the one you'll want
at the worst moment.

Then run the card once and fill in the timing column. Not an estimate, the actual time. That
column is a document saying how long this takes on your box with your data, and you cannot buy it.
It ships blank and this repo will not guess at it. The only shape anybody can offer is the ratio:
the machine's part is fast, the hour is yours, and most of that hour is verification and waiting.

**Success:** `openclaw --version` reports the target. `openclaw gateway probe` matches your healthy
baseline **including the app version on the last line**. Every channel answered a real message.
Counts match.

That app-version check catches a nasty one: a probe reporting a version you didn't just install
means the CLI moved and the desktop app did not, and both are looking at the same state.

**On your install:** the update timeout is **1800 seconds** by default. Kill it at four minutes
because the terminal went quiet and you have converted a slow upgrade into a half-updated install.
`openclaw update repair` exists because enough people did that to need a command for it. There
is also a designed quiet period of five minutes before publication. Silence is not a hang.

Check the tag with `npm view openclaw dist-tags` before you install, not after: a version string
in a blog post is a claim, that is the registry. If you install from a GitHub tag, read the release
**title**. One build shipped labelled `2026.9.1-beta.1` and was actually `2026.8.1-beta.4`, and
the correction lived in the title rather than the version string.

The card also carries the four ways to handle an ssh-only box, where `doctor --fix` silently skips
its work with no terminal attached.
