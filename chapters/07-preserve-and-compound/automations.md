<!-- automations.md (Chapter 7). The why, next to the what. -->

# automations.md

One entry per automation, per agent definition and per channel binding.

Three lines each. The tool can restore your artifacts. Only you can write the third line, and
the third line is the one people actually lose: the records survive an upgrade and the reasoning
does not, because the reasoning only ever existed in the conversation where you set it up.

**Line 3 is doing all the work.** If you could restore an automation but couldn't tell whether
it was working correctly, that line isn't specific enough yet.

---

## Automations

### <name>

- **What it does:**
- **Why it exists:** _what problem were you solving when you built it_
- **What "working" looks like:** _what should you see, and when, if it ran correctly_

### <name>

- **What it does:**
- **Why it exists:**
- **What "working" looks like:**

---

## Agent definitions

### <agent id>

- **What it is for:**
- **Why it is separate:** _a second kind of work is how you stop the first one's context bleeding into it_
- **What "working" looks like:**

---

## Channel bindings

### <channel>

- **Which agent owns it:**
- **Why it exists:**
- **How you would know if it stopped:** _which one would you notice first if it went quiet_

---

**Proved it:** _pick one automation, delete it on the disposable copy, restore it from this
repository, run it, and confirm it did the thing line 3 says it should. Not on production._
