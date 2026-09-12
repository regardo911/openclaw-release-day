<!-- settings-record.md (Chapter 8). A setting you never authored is one you are borrowing. -->

# settings-record.md

One line per setting: the path, what it was, what you set it to, and one sentence on why. The why
is the part that matters in a year, when you are looking at a pinned value and wondering whether
you still mean it.

**Release I was on when I recorded the Before column:**

| Path | Before | After | Why |
|---|---|---|---|
| `tools.sessions.visibility` | | | |
| `tools.agentToAgent.enabled` | | | |
| `tools.swarm.enabled` | | | |
| `agents.defaults.subagents.maxSpawnDepth` | | | |
| `gateway.cliAgents.enabled` | | | |

`record-before.sh` fills Before from your own install. After and Why are decisions.

## What each one controls

**`tools.sessions.visibility`** decides who can read your agent's transcripts. `self` is only the current
session; `agent` is any session belonging to this agent, **including other users**; `all` is any
session on the gateway, including other agents and users.

**`tools.agentToAgent.enabled`** decides whether agents can reach into each other's sessions. An empty
allow list is not a restriction: omitted or empty permits every agent pair.

**`tools.swarm.enabled`** decides whether work fans out across collectors. If you don't know you want
this, you want it off.

**`agents.defaults.subagents.maxSpawnDepth`** decides how deep nesting goes. `1` makes direct children
leaves. A blast-radius setting and a cost setting at the same time.

**`gateway.cliAgents.enabled`** decides whether command-line agents can drive the gateway.

## Where the defaults were

Dated the moment they are printed. Here to show you that defaults move and what the movement looks
like, not to tell you what yours are. Ask your own install.

| Setting | 8.1 | 8.2 | 9.1 | 9.2 | 9.4 |
|---|---|---|---|---|---|
| `tools.sessions.visibility` | `tree` | **`agent`** | `agent` | **`all`** | `all` |
| `tools.agentToAgent.enabled` | off | off | off | **`true`** | `true` |
| `tools.swarm.enabled` | off | off | off | **on** | on |
| `agents.defaults.subagents.maxSpawnDepth` | 1 | 1 | 1 | 1 | **5** |
| `gateway.cliAgents.enabled` | false | false | false | false | **true** |

Three releases moved something. One moved three things at once.

## Audit findings I closed

| Severity | checkId | Closed on | How |
|---|---|---|---|
| | | | |

CRITICAL first. Take the remediation from the tool rather than anybody's blog, because the one it
gives you matches your release.
