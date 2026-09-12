# Chapter 8: Pin the defaults

A setting you never authored is not one you chose. It is one you are borrowing from whoever cut
the last release.

**What you build:** a config where every session, agent-to-agent, swarm, nesting and CLI-agent
setting is authored by hand, plus `settings-record.md`: what each was before, what you set it to,
and one sentence on why.

```bash
./record-before.sh        # your before-state, into the inventory
# decide each one, then openclaw config set ...
./prove-authored.sh       # 5 authored  — or: still a default: tools.swarm.enabled, exit 1
./audit-remediations.sh   # every finding with the fix your own release prescribes
```

Save an audit run before you fix anything and another after, so the diff is the record of what you
closed. `FIX: null` on the informational summary line is correct: that finding asks you to do
nothing.

## The four characters that are the whole gate

`config get` prints its message on **standard error**. Without `2>&1` the check reads an empty
stream, matches nothing, and reports success on an install where you have authored nothing.

The exit code cannot help, which is chapter 4's trap running the other way. Only an **authored**
value exits 0. "Valid but unset" and "unknown path" **both** exit 1 and need opposite fixes: one
is an inherited default, the other is a typo.

So this sweep reads the message, and reads for both. The printed version looks only for the first,
and `settings-paths.txt` is a file you edit, which makes a typo a realistic way to certify a
setting you never pinned. It counts from the file rather than saying "all five", because you will
add keys.

**Success:** the sweep prints a count and exits 0. Then unset one, run it again, and confirm it
fails with the path named. **A gate you have never seen fail is a gate you do not know works.**

**On your install:** pinning by hand disagrees with the vendor's posture. Theirs is: run on
defaults, audit for drift. That's reasonable for a product shipping this fast. The
counter-argument is that three releases moved these, two of the moves widened who can see your
agent's work, and you are one person who needs the thing to be the same tomorrow as today. The cost
is being occasionally pinned to an old default a later release improved. Disagree deliberately.

Careful with `security audit --fix` on an install you just pinned: it changes your config without
you reading the diff. Run it on the chapter 4 copy first.

There is no `.env.example` here. This chapter's argument is that credentials belong outside the
agent's reach, and an environment template beside it would contradict that.
