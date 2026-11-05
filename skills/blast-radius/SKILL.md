---
name: blast-radius
description: Before a risky change, map everything it reaches and what could break. Read-only.
argument-hint: "<function, file, diff or planned change>"
disable-model-invocation: true
---

Map what the change (none: this session's planned or uncommitted change) reaches. **Change nothing.** Use a subagent for searches wider than a few files.

Search by every name the code goes by, not just the symbol: string references, routes, config keys, events, queued jobs, templates, serialized data, reflection or dynamic calls, other repos or apps that call it.

Report, each item with `path:line`:

- **Must change**: callers, overrides and fixtures that break if left alone.
- **Might break**: indirect users whose behaviour shifts (output, timing, order, nulls, errors).
- **Data and users**: stored data, migrations, caches, queues, public APIs, exports, emails; anything it could destroy, expose or make stale.
- **Tests**: which cover it, and which parts nothing covers.
- **Can't see**: what the search can't prove (dynamic calls, other services, production data).

End with a risk level (low / medium / high) and its one-line reason, then a safe order to make the change.
