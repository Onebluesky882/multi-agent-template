# Multi-Agent AI Template

A starter template for running a project with a **Dev / Conductor / Worker** multi-agent workflow. Dev sets direction; the Conductor orchestrates stages and gates; each Worker owns exactly one pipeline stage, in its own branch, producing one PR.

## Authority Order

```
Dev  >  Conductor  >  Workers
```

- **Dev** — project owner/human lead. Sets direction, workflow, design conventions, and tech stack. Only Dev may pin package versions in `DECISIONS.md`.
- **Conductor** — orchestrates Workers: dispatches, validates gates, merges PRs. Must not act until `QUESTIONS.md` is fully answered.
- **Workers** — execute assigned stages only, within their defined domain.

---

## Files

| File | Owner | Purpose |
|------|-------|---------|
| `QUESTIONS.md` | Dev | Project setup questionnaire — must be answered before pipeline starts |
| `GOVERNANCE_CORE.md` | Dev | File ownership table, reading order, authority order |
| `DEV.md` | Dev | Dev authority, override rules, edit logging |
| `DEV_LOG.md` | Dev | Log of all direct Dev edits; Conductor reconciles against this |
| `PROJECT.md` | Conductor | Project goal, tech stack, current status |
| `ROADMAP.md` | Conductor | Long-term direction, milestones, current progress |
| `ARCHITECTURE.md` | Conductor | System architecture, modules, constraints |
| `CONTRACTS.md` | Conductor | Public interfaces between modules |
| `DECISIONS.md` | Conductor | Architectural decisions + Pinned Versions table |
| `SECURITY_RULES.md` | Conductor | Mandatory security requirements for all agents |
| `PIPELINE.md` | Conductor | Stage list, status, acceptance criteria |
| `AGENT_RULES.md` | Conductor | Full workflow rules + gate-out template |
| `CONDUCTOR.md` | Conductor | Conductor role, responsibilities, restrictions |
| `START_HERE.md` | Worker | Mandatory worker onboarding entry point |
| `CLAUDE.md` | All agents | Project-level instructions loaded automatically |
| `tasks/stage-[N]-<domain>.md` | Conductor | Dispatch instructions for a stage |
| `gate-out/stage-[N]-<domain>.md` | Worker | Self-reported proof of stage completion |
| `merge-approval/stage-[N]-<domain>.md` | Conductor | Approval to merge a stage's PR |
| `rejection/stage-[N]-<domain>.md` | Conductor | Reason a gate-out failed |
| `docs/adrs/` | Conductor/Worker | Architecture Decision Records |

### Pipeline artifact folders

```
tasks/             Conductor -> Worker   dispatch instructions
gate-out/          Worker -> Conductor   proof of completion
merge-approval/    Conductor             approval to merge
rejection/         Conductor             why gate-out FAILed
```

Each folder holds one flat file per stage: `stage-[N]-<domain>.md`. No subfolders.

---

## Setup — Before Starting the Pipeline

### Step 1 — Dev answers QUESTIONS.md

Open `QUESTIONS.md` and answer all questions (29 questions across 7 sections):

| Section | Covers | Updates |
|---------|--------|---------|
| 1 — Project Identity | name, core problem, target users | PROJECT.md |
| 2 — Tech Stack | language, framework, database, auth | DECISIONS.md |
| 3 — Architecture | structure, modules, external services | ARCHITECTURE.md, CONTRACTS.md |
| 4 — Code Style | naming, linting, testing, TypeScript | DECISIONS.md |
| 5 — Pipeline & Stages | stages, dependencies, conductor-branch ⚠️ | PIPELINE.md |
| 6 — Roadmap | goals, vision, milestone | ROADMAP.md |
| 7 — Security | sensitive data, environments, compliance | SECURITY_RULES.md |

### Step 2 — Conductor updates governance files

Conductor reads all answers and updates every governance file per the Conductor Instructions in `QUESTIONS.md`.

### Step 3 — Run Setup Test

Run all 8 Setup Tests in `QUESTIONS.md` to verify governance is ready before starting the pipeline.

### PRE-FLIGHT CHECK (mandatory)

Both Conductor and Worker are `BLOCKED: PROJECT NOT CONFIGURED` if `<conductor-branch>` is still a literal placeholder:

```bash
grep -rn "<conductor-branch>" PIPELINE.md PROJECT.md AGENT_RULES.md README.md
```

No output = ready. Any output = return to Step 1.

---

## Required Reading Order (Workers)

See `GOVERNANCE_CORE.md` for the full reading order (files 0–11).

---

## Running a Stage (Conductor)

1. Confirm PRE-FLIGHT CHECK passes.
2. Confirm all `Depends On` stages are `COMPLETE` and merged.
3. Write `tasks/stage-[N]-<domain>.md` — stage number, domain, Depends On, model, context files, task description, `Gate-In Verified: YES`.
4. Set `Status: IN_PROGRESS` in `PIPELINE.md`.
5. Dispatch the worker agent.

Stages with `Depends On: none` or fully `COMPLETE` dependencies may be dispatched in parallel.

---

## Running a Stage (Worker)

1. Read `START_HERE.md` — PRE-FLIGHT CHECK runs here.
2. Read all files in the order defined in `GOVERNANCE_CORE.md`.
3. Locate the stage with `Status: IN_PROGRESS` and confirm `tasks/stage-[N]-<domain>.md` exists with `Gate-In Verified: YES`. If not, STOP → `BLOCKED: WAITING_FOR_GATE_IN`.
4. Implement only the assigned domain. Create branch `feature/[domain]`.
5. Check package versions before every install — see Version Policy below.
6. Run tests and build verification.
7. Create `gate-out/stage-[N]-<domain>.md` using the template in `AGENT_RULES.md → Stage Completion`.
8. STOP — do not merge, do not start the next stage.

---

## Gate Validation (Conductor)

1. Read `gate-out/stage-[N]-<domain>.md`.
2. PASS requires: `status: PASS`, `ready_for_next: YES`, all acceptance criteria met, no blocking issues, SECURITY_RULES.md compliance verified.
3. REJECT → write `rejection/stage-[N]-<domain>.md` and halt.
4. PASS →
   - Update `PIPELINE.md` → Stage `[N]` = `COMPLETE`.
   - Write `merge-approval/stage-[N]-<domain>.md`.
   - After squash-merge into `<conductor-branch>`, unlock any `PENDING` stages whose dependencies are now fully `COMPLETE`.

---

## Version Policy

Workers must verify the current version at runtime before installing any package. Training-data version numbers are not authoritative.

```bash
npm info <package> version    # Node
pip index versions <package>  # Python
cargo search <package>        # Rust
```

Bootstrap commands must always use `@latest`:

```bash
npm create vite@latest
npx create-next-app@latest
npx create-expo-app@latest
```

**Exception:** packages listed in the **Pinned Versions** table in `DECISIONS.md` must use the exact pinned version — do not use `@latest`. Only Dev may modify the Pinned Versions table; all changes must be logged in `DEV_LOG.md`.

---

## Dev Direct Edits

When Dev edits any file directly:

1. Dev adds an entry to `DEV_LOG.md`.
2. Conductor reads `DEV_LOG.md` and reconciles `ROADMAP.md`, `PROJECT.md`, and `PIPELINE.md`.

---

## Conductor-Only Work

Tasks that must never be dispatched to a worker (cross-stage integration, e2e tests, hardware access) — mark `Owner: CONDUCTOR` in `PIPELINE.md`.

---

## ADRs

```bash
ls docs/adrs/ | sort | tail -3
```

Take the highest number, add 1, name the file `NNN-short-slug.md` with a matching `# ADR NNN — Title` header inside.

---

## Key Rules at a Glance

- **Setup gate** — answer `QUESTIONS.md` and pass all Setup Tests before starting the pipeline.
- **PRE-FLIGHT** — `<conductor-branch>` still a placeholder → BLOCKED immediately.
- One stage = one branch = one PR = one merge into `<conductor-branch>`.
- A `COMPLETE` stage is immutable — bugs become new stages, not edits.
- Workers may NOT edit any governance file.
- Always verify package versions at runtime — training-data versions are unreliable.
- Security violation → `Status: FAIL`, `Ready For Next Stage: NO`.
- Never commit build artifacts (`node_modules/`, `dist/`, `build/`, `.next/`, `target/`, `__pycache__/`, `.venv/`, `vendor/`).

Full rules → `AGENT_RULES.md` | Authority model → `GOVERNANCE_CORE.md` | Setup → `QUESTIONS.md`
