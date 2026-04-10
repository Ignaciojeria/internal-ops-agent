---
name: honcho-memory-core
description: Integrate and operate persistent memory with pi-memory-honcho using a repository-first workflow. Use when tasks require durable context, per-repo session isolation, or memory synchronization across sessions.
license: MIT
metadata:
  author: ignacio-jeria
  version: "1.0.0"
  category: memory
---

# Honcho Memory Core

## When to use this skill
- When work depends on prior project decisions.
- When historical context is needed across sessions.
- When memory must stay isolated by repository.
- When stable preferences/decisions need to be stored durably.

## Operational objective
Use Honcho as the project's core memory layer with a **repo-first** approach, avoiding cross-project context bleed.

## Recommended configuration
In `~/.honcho/config.json`, under `hosts.pi`:

- `sessionStrategy: "per-repo"` (recommended)
- `recallMode: "hybrid"`
- `writeFrequency: "async"`

Minimal example:

```json
{
  "apiKey": "hch-v3-...",
  "peerName": "ignacio",
  "hosts": {
    "pi": {
      "workspace": "pi",
      "aiPeer": "pi",
      "recallMode": "hybrid",
      "sessionStrategy": "per-repo"
    }
  }
}
```

## Per-session workflow
1. Verify health:
   - `/honcho:doctor`
   - `/honcho:status`
2. If session identity is unclear, map the repo explicitly:
   - `/honcho:map` (set per-repo session name)
3. During work:
   - `honcho_context` for synthesized memory context
   - `honcho_search` for targeted memory retrieval
   - `honcho_profile` for stable user/profile context
4. At decision points:
   - `honcho_conclude` for durable facts/policies

## Repo-first rules
- Store conclusions with a project prefix (e.g., `internal-ops-agent:`).
- Avoid generic conclusions without project context.
- Prefer `honcho_context` before strategy/architecture decisions.
- Write only stable facts (preferences, decisions, constraints).

## Quick templates

### Conclude (durable decision)
```text
internal-ops-agent: Runtime stack is Pi + Honcho + GitAgent-style structure.
```

### Query (context retrieval)
```text
What are the current decisions and constraints for internal-ops-agent?
```

## Do / Don't
- ✅ Do: use Honcho for real continuity across sessions.
- ✅ Do: run `/honcho:doctor` when memory behavior seems wrong.
- ❌ Don't: store temporary noise or unverified outputs.
- ❌ Don't: assume memory replaces reading repo files.
