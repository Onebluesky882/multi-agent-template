# PIPELINE.md

## Worktree Rule — MANDATORY

Each stage runs in its own git worktree on its own branch. One worktree = one stage = one branch. No exceptions.

**Conductor creates worktrees before dispatching:**
```bash
git worktree add ../worktrees/stage-1-<name> -b stage-1-<name>
git worktree add ../worktrees/stage-2-<name> -b stage-2-<name>
```

**Workers must NOT:**
- Work on `main` directly
- Share a worktree with another stage
- Cross-write files owned by another stage's domain

**Why:** parallel stages running in the same working tree will corrupt each other's gate-out, type-check state, and branch history. Worktrees are the only safe parallel execution model.

⸻

## Stages

| State | Domain | Depends On | Status |
|-------|--------|------------|--------|
| state-1-[name] | [module name] | none | PENDING |
| state-2-[name] | [module name] | none | PENDING |

<!--
Depends On lists the state IDs (comma-separated, or "none") that must reach
COMPLETE before this stage may move PENDING -> IN PROGRESS.

Stages with no overlapping dependencies may run IN PROGRESS at the same time,
each on its own branch (1 stage = 1 workspace). A stage only waits when it is
listed in another stage's Depends On.
-->

⸻

## Stage Detail

### state-1-[name] — [Name]

**Domain:** modules/[name]
**Agent:** [assigned agent]
**Depends On:** none
**Status:** `PENDING` → `IN PROGRESS` → `COMPLETE` | `BLOCKED`

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

**Gate-In Requirements:**
<!-- What must be true before this stage can start -->

**Dispatch-In:** `tasks/state-1-[name].md`
<!-- Conductor writes this once all stages in Depends On are COMPLETE and
     merged to <conductor-branch>. If Depends On = none, this can be written
     immediately and run in parallel with other independent stages. -->

**Gate-Out:** `gate-out/state-1-[name].md`
<!-- Agent writes this when stage is complete -->

**Merge-Approval:** `merge-approval/state-1-[name].md`
<!-- Conductor writes this after gate validation passes; triggers PR merge -->

**Rejection (if any):** `rejection/state-1-[name].md`
<!-- Conductor writes this if gate validation fails -->

⸻

<!-- Repeat for each stage -->
