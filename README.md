# Multi-Agent AI Template

A starter template for running a project with a **Dev / Conductor / Worker** multi-agent
workflow. Dev sets direction; the Conductor orchestrates stages and gates; each Worker
owns exactly one pipeline stage, in its own branch, producing one PR.

## Authority Order

```
Dev  >  Conductor  >  Workers
```

- **Dev** — project owner/human lead. Sets direction, workflow, design conventions, and tech stack.
- **Conductor** — orchestrates Workers: dispatches, validates gates, merges PRs.
- **Workers** — execute assigned stages only, within their defined domain.

## Files

| File | Owner | Purpose |
|------|-------|---------|
| `GOVERNANCE_CORE.md` | Dev | Shared governance reference — file ownership table, reading order, authority order |
| `DEV.md` | Dev | Dev authority, override rules, edit logging requirements |
| `DEV_LOG.md` | Dev | Log of direct Dev edits; Conductor reconciles against this |
| `PROJECT.md` | Conductor | Project goal, tech stack, current status |
| `ROADMAP.md` | Conductor | Long-term direction, business goals, current progress, next steps |
| `ARCHITECTURE.md` | Conductor | System architecture, modules, constraints |
| `CONTRACTS.md` | Conductor | Public interfaces between modules |
| `DECISIONS.md` | Conductor | Authoritative architectural decisions |
| `SECURITY_RULES.md` | Conductor | Mandatory security requirements for all agents |
| `PIPELINE.md` | Conductor | Stage list, status, acceptance criteria |
| `AGENT_RULES.md` | Conductor | Full workflow rules for all agents |
| `CONDUCTOR.md` | Conductor | Conductor role definition, responsibilities, and restrictions |
| `START_HERE.md` | Worker | Onboarding instructions for worker agents |
| `CLAUDE.md` | All agents | Project-level instructions loaded automatically |
| `tasks/stage-[N]-<domain>.md` | Conductor | Dispatch instructions for a stage |
| `gate-out/stage-[N]-<domain>.md` | Worker | Self-reported proof of stage completion |
| `merge-approval/stage-[N]-<domain>.md` | Conductor | Approval to merge a stage's PR |
| `rejection/stage-[N]-<domain>.md` | Conductor | Reason a stage's gate-out failed |
| `docs/adrs/` | Conductor/Worker | Architecture Decision Records |

### Pipeline artifact folders

```
tasks/             Conductor -> Worker   "go" / dispatch instructions
gate-out/          Worker -> Conductor   self-reported proof of completion
merge-approval/    Conductor             approval to merge (after gate-out PASS)
rejection/         Conductor             why gate-out FAILed, what to fix
```

Each folder holds one flat file per stage: `stage-[N]-<domain>.md`.
No per-stage subfolders.

## Required Reading Order (Workers)

All workers must read, in order:

0. `GOVERNANCE_CORE.md`
1. `PROJECT.md`
2. `ROADMAP.md`
3. `ARCHITECTURE.md`
4. `CONTRACTS.md`
5. `DECISIONS.md`
6. `SECURITY_RULES.md`
7. `AGENT_RULES.md`
8. `PIPELINE.md`
9. `CONDUCTOR.md`
10. `DEV.md`
11. `DEV_LOG.md`

## Setup (before starting any stage)

1. Fill in `PROJECT.md` — name, goal, tech stack, status.
2. Fill in `ROADMAP.md` — long-term direction and milestones.
3. Fill in `ARCHITECTURE.md` — modules, data flow, constraints.
4. Fill in `CONTRACTS.md` — input/output contracts for each module.
5. Fill in `DECISIONS.md` — any decisions agents must follow (libraries, frameworks, etc.).
6. Fill in `SECURITY_RULES.md` — security requirements and restrictions.
7. Define stages in `PIPELINE.md` — one row per stage, with domain and acceptance criteria.
8. Replace `[name]` placeholders in `AGENT_RULES.md` (Domain Ownership, Branch Rules, File Ownership) with your actual module names.

## Running a stage (Conductor)

1. Confirm all `Depends On` stages are `COMPLETE` and merged.
2. Write `tasks/stage-[N]-<domain>.md` with:
   - Stage number, domain, `Depends On`, model
   - Context files to read
   - Task description
   - `Gate-In Verified: YES`
3. Set the stage's `Status: IN_PROGRESS` in `PIPELINE.md`.
4. Dispatch the worker agent.

Stages whose `Depends On` is `none` or fully `COMPLETE` may be dispatched in parallel.

## Running a stage (Worker)

1. Read `START_HERE.md`.
2. Read files in the required reading order above.
3. Find your stage (`Status: IN_PROGRESS`) and confirm `tasks/stage-[N]-<domain>.md` exists with `Gate-In Verified: YES`. If not, STOP and report `BLOCKED: WAITING_FOR_GATE_IN`.
4. Implement only what's in your assigned domain. Create branch `feature/[domain]`.
5. Run tests and build verification.
6. Write `gate-out/stage-[N]-<domain>.md` with status, modified files, tests run, acceptance criteria, known issues, and `Ready For Next Stage: YES|NO`.
7. STOP. Do not merge, do not start the next stage.

## Gate validation (Conductor)

1. Read `gate-out/stage-[N]-<domain>.md`.
2. PASS only if: `Status: PASS`, `Ready For Next Stage: YES`, all acceptance criteria checked, no blocking known issues, SECURITY_RULES.md compliance verified.
3. On REJECT: write `rejection/stage-[N]-<domain>.md` and halt.
4. On PASS:
   - Update `PIPELINE.md` — Stage `[N]` → `COMPLETE`.
   - Write `merge-approval/stage-[N]-<domain>.md`.
   - After the PR is squash-merged to `<conductor-branch>`, for every `PENDING` stage whose `Depends On` is now fully `COMPLETE`, update `PIPELINE.md` → `IN_PROGRESS` and write `tasks/stage-[M]-<domain>.md`.

## Dev direct edits

When Dev edits any governance or source file directly:

1. Dev adds an entry to `DEV_LOG.md`.
2. After the edit, Conductor reads `DEV_LOG.md` and reconciles:
   - `ROADMAP.md` — Current Progress / Next Steps
   - `PROJECT.md` — Current Stage / Status (if affected)
   - `PIPELINE.md` — stages (if affected)

## Conductor-only work

Some tasks (cross-stage integration, end-to-end tests, hardware access) must never be dispatched to a worker. Mark these `Owner: CONDUCTOR` in `PIPELINE.md` and `tasks/stage-[N]-<domain>.md`.

## ADRs

Before creating a new ADR, run:

```bash
ls docs/adrs/ | sort | tail -3
```

Take the highest number, add 1, and name the file `NNN-short-slug.md` with a matching `# ADR NNN — Title` header inside.

## Key rules at a glance

- One stage = one branch = one PR = one merge into `<conductor-branch>`.
- A stage's `Depends On` (in `PIPELINE.md`) lists the stages it must wait for. `Depends On: none` (or already-`COMPLETE` deps) means it can run in parallel with other independent stages.
- A `COMPLETE` stage is immutable — bugs become new stages, not edits.
- Workers may NOT edit any governance file (see `GOVERNANCE_CORE.md` ownership table).
- Security violations → `Status: FAIL`, `Ready For Next Stage: NO` (see `SECURITY_RULES.md`).
- Never push build artifact directories (`target/`, `node_modules/`, `dist/`, `build/`, `.next/`, `__pycache__/`, `.venv/`, `vendor/`, ...).

For the full rule set, read `AGENT_RULES.md`. For the full authority model, read `GOVERNANCE_CORE.md`.
