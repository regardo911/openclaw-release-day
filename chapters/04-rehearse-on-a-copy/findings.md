<!-- findings.md (Chapter 4). What broke on your own data, in the order it broke. -->

# Rehearsal findings

The order is the point. These failures cascade, and the second one is often caused by the first.
A summary loses that. A numbered list keeps it.

One person's real list from this exercise ran to six items, and only the first was a root cause.
He could not have found number five on day one no matter how carefully he read the logs, because
number one was hiding it.

Yours will be shorter. It will also be yours, which makes it worth more than his.

---

**Target release rehearsed:**

**Date:**

**Restart cycles the copy took before it came up:**
_Count them. This is the number you compare production against in chapter 5. Two in rehearsal
and two in production is the shape of the thing. Two in rehearsal and five in production is new
information and chapter 6 starts there._

---

1.
2.
3.
4.
5.
6.

---

**Did the copy reach the target version, or fail in a way you can name?**

_Both of those pass. A rehearsal that ends in failure has done its whole job: it moved the
failure off Sunday afternoon on your real install and onto Saturday morning on a file you can
delete. What does not pass is a rehearsal you abandoned halfway because it got annoying._

---

**Plugins present in the inventory and missing from the copy:**
_`openclaw plugins list` against the copy, compared against section 6 of your inventory.
Ninety seconds, and it is the cheapest thing standing between you and a boot failure._
