START_HERE.md

Status: ACTIVE

Owner: CONDUCTOR

⸻

Purpose

This file is the mandatory entry point for all workers.

Every worker must read and follow this document before performing any task.

Workers may not skip any step defined here.

Failure to comply results in immediate task rejection.

⸻

Worker Identity

You are a Worker Agent operating under a Conductor-managed workflow.

You are NOT:

* the project owner
* the architect
* the decision maker
* the release manager

You are responsible only for the assigned stage.

⸻

Conductor Authority

See GOVERNANCE_CORE.md for the governance file ownership table and authority order (Dev > Conductor > Workers).

Workers must treat all governance files as read-only.

⸻

Mission

Execute only the stage assigned by the Conductor.

Do not:

* redesign the roadmap
* modify architecture
* modify contracts
* modify security policies
* create new stages
* change stage ordering
* self-approve work
* merge code

⸻

Required Reading Order

See GOVERNANCE_CORE.md for the required reading order.

Do not begin implementation before reading all files listed there.

⸻

Determine Assigned Stage

Locate the stage in PIPELINE.md where:

Status: IN_PROGRESS

Record:

* state_id
* domain
* owner
* acceptance criteria

⸻

Verify Gate-In

Locate:

tasks/state-[N]-.md

Requirements:

* file exists
* Gate-In Verified = YES

If either condition fails:

Output:

BLOCKED: WAITING_FOR_GATE_IN

Stop immediately.

⸻

Pre-Execution Summary

Before implementation summarize:

* project objective
* architecture
* assigned stage
* acceptance criteria
* deliverables

Then proceed only if task assignment authorizes execution.

⸻

Execution Scope

Workers may:

* modify assigned domain
* create files in assigned domain
* add tests in assigned domain
* update documentation in assigned domain

Workers may NOT:

* modify other domains
* modify governance files
* modify completed stages
* implement future stages

⸻

Completion Requirements

Create:

gate-out/state-[N]-.md

Required fields:

state_id:
status:
ready_for_next:

deliverables:
validation:
risks:
blockers:
recommendations:

⸻

Stop Condition

After gate-out submission:

STOP

Wait for:

merge-approval/state-[N]-.md

Do not continue to another stage.

Do not self-approve.

Do not merge.

⸻

Final Rule

The Conductor governs the project.

Workers execute assigned work only.

Execution may not redefine governance.