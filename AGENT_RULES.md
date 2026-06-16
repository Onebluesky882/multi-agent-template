AGENT_RULES.md

Status: ACTIVE

Owner: CONDUCTOR

⸻

Purpose

Defines worker behavior, execution boundaries, compliance requirements, and governance protections. All workers must follow these rules.

Violation → Default Violation Rule in GOVERNANCE_CORE.md (Status: FAIL, Ready For Next Stage: NO).

⸻

Governance Protection

See GOVERNANCE_CORE.md for the governance file ownership table. Workers may NOT modify any governance file. Only Dev and Conductor may, per that table.

⸻

Worker Scope

Each worker owns one stage, one branch, one domain. Workers may not execute tasks outside assigned scope.

⸻

Main Branch Merge Authority

Agents may NOT create, rename, delete, or re-point the main branch. `main` is owned exclusively by Dev.

⸻

Domain Ownership

Workers may only modify files inside their assigned domain. Cross-domain changes require explicit Conductor approval.

⸻

Technology Stack Authority

DECISIONS.md is authoritative. Workers must use approved technologies and must NOT replace frameworks, libraries, databases, authentication systems, or infrastructure without Conductor approval.

Workers must use the latest stable version of approved technologies unless DECISIONS.md explicitly pins a version. Workers may NOT use deprecated, unsupported, or end-of-life releases or bootstrap from outdated templates (e.g. use `npm create vite@latest`, `npx create-expo-app@latest`).

⸻

Dependencies

Prefer existing dependencies. If a new dependency is required, document in gate-out.md: package, version, reason. See SECURITY_RULES.md for supply chain and security requirements.

⸻

Testing Rules

Required: build verification, unit tests, type checks. Workers may not claim tests passed unless executed.

⸻

Error Handling

Applications must fail gracefully. Return structured errors. Never intentionally crash systems.

⸻

Sub-Agent Restriction

Workers may NOT create, dispatch, or generate new workers or autonomous agents, delegate tasks, or create recursive execution chains. Only the Conductor may create workers.

⸻

Security Rules

See SECURITY_RULES.md for all security requirements (secrets, access control, data, network, APIs, dependencies, cryptography, infrastructure, CI/CD).

⸻

Build Artifact Rules

Never commit: `node_modules/`, `dist/`, `build/`, `.next/`, `target/`, `vendor/`, `__pycache__/`, `.venv/`. Verify `.gitignore` before push.

⸻

Stage Completion

Worker must create `gate-out/stage-[N]-<domain>.md` and provide:
* modified files
* tests run
* dependencies added
* acceptance criteria status
* known issues

⸻

Final Rule

Workers execute. Conductor decides. Governance overrides implementation.
