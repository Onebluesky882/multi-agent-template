# PIPELINE.md

## Stages

| State | Domain | Status |
|-------|--------|--------|
| state-1-[name] | [module name] | PENDING |
| state-2-[name] | [module name] | PENDING |

⸻

## Stage Detail

### state-1-[name] — [Name]

**Domain:** modules/[name]
**Agent:** [assigned agent]
**Status:** `PENDING` → `IN PROGRESS` → `COMPLETE` | `BLOCKED`

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

**Gate-In Requirements:**
<!-- What must be true before this stage can start -->

**Dispatch-In:** `tasks/state-1-[name].md`
<!-- Conductor writes this AFTER prior stage PR is merged to dev (or main if dev does not exist) -->

**Gate-Out:** `gate-out/state-1-[name].md`
<!-- Agent writes this when stage is complete -->

**Merge-Approval:** `merge-approval/state-1-[name].md`
<!-- Conductor writes this after gate validation passes; triggers PR merge -->

**Rejection (if any):** `rejection/state-1-[name].md`
<!-- Conductor writes this if gate validation fails -->

⸻

<!-- Repeat for each stage -->
