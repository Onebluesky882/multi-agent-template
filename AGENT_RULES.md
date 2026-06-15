AGENT_RULES.md

Status: ACTIVE

Owner: CONDUCTOR

⸻

Purpose

Defines worker behavior, execution boundaries, compliance requirements, and governance protections.

All workers must follow these rules.

Unless a rule below states otherwise, any violation results in the Default Violation Rule in GOVERNANCE_CORE.md (Status: FAIL, Ready For Next Stage: NO).

⸻

Governance Protection

See GOVERNANCE_CORE.md for the governance file ownership table.

Workers may NOT modify any governance file. Only Dev and Conductor may, per that table.

⸻

Worker Scope

Each worker owns:

* one stage
* one branch
* one domain

Workers may not execute tasks outside assigned scope.

⸻

Main Branch Merge Authority

Agents may NOT create, rename, delete, or re-point the main branch.

main is owned exclusively by the dev.

⸻

Domain Ownership

Workers may only modify files inside their assigned domain.

Cross-domain changes require explicit Conductor approval.

⸻

Technology Stack Authority

DECISIONS.md is authoritative.

Workers must use approved technologies.

Workers may NOT:

* replace frameworks
* replace libraries
* replace databases
* replace authentication systems
* replace infrastructure

without Conductor approval.

⸻

Technology Freshness Compliance

Workers must use the latest stable version of approved technologies unless DECISIONS.md explicitly pins a version.

Workers may NOT:

* use deprecated releases
* use unsupported releases
* use end-of-life releases
* bootstrap projects from outdated templates

Examples:

* npm create vite@latest
* npx create-expo-app@latest

⸻

Dependency Rules

Prefer existing dependencies.

Workers may not add dependencies unless required.

If added:

Document:

* package
* version
* reason

inside gate-out.md

⸻

Dependency Security

Dependencies must originate from approved public registries or repositories approved by DECISIONS.md.

Undocumented dependencies fail validation.

⸻

Testing Rules

Required:

* build verification
* unit tests
* type checks

Workers may not claim tests passed unless executed.

⸻

Error Handling

Applications must fail gracefully.

Return structured errors.

Never intentionally crash systems.

⸻

Sub-Agent Restriction

Workers may NOT:

* create new workers
* dispatch new workers
* generate autonomous agents
* delegate tasks
* create recursive execution chains

Only the Conductor may create workers.

⸻

Data Access Restrictions

Workers may NOT:

* export databases
* dump tables
* collect user data
* access production data
* access secrets

unless explicitly assigned.

⸻

Network Restrictions

Workers may NOT:

* expose public APIs
* expose new ports
* create admin endpoints
* create debug endpoints
* create export endpoints

unless explicitly defined in:

* ARCHITECTURE.md
* CONTRACTS.md

⸻

Security Authority

SECURITY_RULES.md is authoritative.

Workers must comply with all security requirements.

Security violations automatically fail validation.

⸻

Build Artifact Rules

Never commit:

* node_modules/
* dist/
* build/
* .next/
* target/
* vendor/
* pycache/
* .venv/

Verify .gitignore before push.

⸻

Stage Completion

Worker must create:

gate-out/state-[N]-.md

and provide:

* modified files
* tests
* dependencies added
* acceptance criteria status
* known issues

⸻

Final Rule

Workers execute.

Conductor decides.

Governance overrides implementation.