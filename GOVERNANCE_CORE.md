GOVERNANCE_CORE.md

Status: ACTIVE

Owner: DEV

⸻

Purpose

Shared reference for governance structure, referenced by START_HERE.md, AGENT_RULES.md, ROADMAP.md, and SECURITY_RULES.md.

Avoids repeating the same tables and rules in multiple files.

⸻

Governance File Ownership

| File | Owner | Dev may edit directly | Conductor may edit | Workers |
|------|-------|------------------------|---------------------|---------|
| PROJECT.md | Conductor | Yes | Yes | Read-only |
| ROADMAP.md | Conductor | Yes | Yes | Read-only |
| PIPELINE.md | Conductor | Yes | Yes | Read-only |
| ARCHITECTURE.md | Conductor | Yes | Yes | Read-only |
| CONTRACTS.md | Conductor | Yes | Yes | Read-only |
| DECISIONS.md | Conductor | Yes | Yes | Read-only |
| SECURITY_RULES.md | Conductor | Yes | Yes | Read-only |
| AGENT_RULES.md | Conductor | Yes | Yes | Read-only |
| CONDUCTOR.md | Conductor | Yes | Yes | Read-only |
| DEV.md | Dev | Yes | No | Read-only |
| DEV_LOG.md | Dev | Yes | No | Read-only |
| GOVERNANCE_CORE.md | Dev | Yes | No | Read-only |

Any direct Dev edit to a file above must be logged in DEV_LOG.md (see DEV.md).

⸻

Required Reading Order

All workers must read, in order:

0. GOVERNANCE_CORE.md (this file)
1. PROJECT.md
2. ROADMAP.md
3. ARCHITECTURE.md
4. CONTRACTS.md
5. DECISIONS.md
6. SECURITY_RULES.md
7. AGENT_RULES.md
8. PIPELINE.md
9. CONDUCTOR.md
10. DEV.md
11. DEV_LOG.md

⸻

Default Violation Rule

Unless a rule states otherwise, any violation of AGENT_RULES.md or SECURITY_RULES.md results in:

Status: FAIL

Ready For Next Stage: NO

⸻

Relationship Between Documents

PROJECT.md — project identity and purpose.

ROADMAP.md — long-term direction, business goals, current progress, next steps.

PIPELINE.md — execution stages and implementation progress.

ARCHITECTURE.md — system structure.

CONTRACTS.md — interfaces and contracts.

DECISIONS.md — approved technical decisions.

AGENT_RULES.md — worker operating rules.

SECURITY_RULES.md — security requirements and restrictions.

CONDUCTOR.md — orchestration behavior.

DEV.md — Dev authority, overrides Conductor and Workers.

DEV_LOG.md — log of direct Dev edits; Conductor reconciles ROADMAP/PROJECT/PIPELINE against it.

⸻

Authority Order

Dev > Conductor > Workers.

Workers execute. Conductor coordinates. Dev directs.

⸻

Write Gate (license_status)

All AI file writes (Edit, Write, NotebookEdit) are gated by `.claude/license_status`.

| Value | Effect |
|-------|--------|
| `ACTIVE` | writes allowed |
| `SUSPENDED` | all writes blocked immediately |
| `REVIEW` | all writes blocked immediately |

Dev is the only authority who may change this file. To pause all AI writing instantly:

```bash
echo "SUSPENDED" > .claude/license_status
```

To restore:

```bash
echo "ACTIVE" > .claude/license_status
```

This is enforced by `.claude/hooks/check-license.sh` (PreToolUse hook). It is not advisory — writes will hard-fail when status ≠ ACTIVE.

⸻

Type-Check Gate (gate-out)

Writing any file under `gate-out/` triggers `.claude/hooks/gate-out-typecheck.sh`, which runs `pnpm type-check` in the repo root. If type-check fails, the gate-out write is rejected. Workers may not self-report type-check results — the hook is the only valid evidence.
