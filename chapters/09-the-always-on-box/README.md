# Chapter 9: The always-on box

A restart policy is not resilience. Five specific things have to be true at once.

## The sequence

`box-build.md`, nine numbered steps, each with its own verify line, so the
second box costs twenty minutes rather than a weekend of remembering.

## Why it died overnight

For the classic "it ran once, then it died overnight":

```bash
./oom-check.sh <container>
```

```
== docker inspect OOMKilled
false
   true here means stop looking at OpenClaw. It is a memory problem in an OpenClaw costume.
== kernel ring buffer
skipped: dmesg -T is Linux-only. On a Mac it exits 1 with 'usage: sudo dmesg' and
tells you nothing about memory. Do not read that as 'no out-of-memory kill'.
```

It refuses with a usage line when you do not name a container.

Your agent reads a web page, a headless browser spawns, and on a small machine that one browser is
a large fraction of everything available. The kernel picks the biggest process. Your gateway goes
away with nothing in the OpenClaw logs, because from OpenClaw's point of view nothing went wrong. It
stopped existing.

The other named cause is simpler: Docker's default is **no restart**, which matches that symptom
perfectly. But "add a restart policy" isn't the answer either. One operator made his box more
stable by **removing** the automatic restart, because an unbounded restart against broken state is
a loop that grinds. Bounded is the word doing the work.

## Done when

You rebooted the box without logging back in to fix anything, the agent answered on
its own within the window your probe allows, and then a real message through a real channel got a
real reply.

## Two things this directory will not do for you

`compose.example.yml` is not named `compose.yml`. A reader running
`docker compose up` inside a clone would start a second gateway against a state directory this book
spends two chapters warning about. Copy it into your own repository, fill in every angle bracket,
rename it there.

Get the bind right before the box has a public address. A regular host install binds to loopback;
**container images default to an exposed bind.** That is the honest version of every exposure
statistic you have read. Not that the product flings itself onto the internet, but that the
containerised path starts more open and the people taking it are least likely to have read a
paragraph about binds. `box-build.md` also has the native path, where that mistake is one you
cannot easily make.
