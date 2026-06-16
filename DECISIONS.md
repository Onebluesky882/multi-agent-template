# DECISIONS.md

## Purpose
Record architectural decisions that all agents must follow. DECISIONS.md is authoritative — workers may not deviate without Conductor approval.

⸻

## Decision: Version Policy

**Date:** 2026-06-16
**Status:** ACCEPTED

**Context:**
Workers default to package versions from training data, which are outdated. Example: choosing Vite v4 when current stable is v8. This causes security exposure and missing features.

**Decision:**
All packages must use the latest stable version at time of installation unless a version is explicitly pinned below in "Pinned Versions". Workers must verify current version at runtime before installing — training-data version numbers are not authoritative.

Mandatory check before install:
```bash
npm info <package> version        # Node
pip index versions <package>      # Python
cargo search <package>            # Rust
```

Bootstrap scaffolds must use `@latest`:
```bash
npm create vite@latest
npx create-next-app@latest
npx create-expo-app@latest
```

See AGENT_RULES.md → Version Policy for enforcement rules and violation consequences.

**Consequences:**
* Workers must run the version check and include verified version in gate-out `dependencies_added`
* Claiming "latest" without the check command output = Status: FAIL
* If a specific version is required, Dev or Conductor must pin it in "Pinned Versions" below

⸻

## Pinned Versions

<!-- List packages that must use a specific version, overriding the @latest rule -->
<!-- Format: package@version — reason -->

(none — all packages use @latest unless added here)

⸻

## Decision: [Title]

**Date:** YYYY-MM-DD
**Status:** ACCEPTED | SUPERSEDED

**Context:**
<!-- Why this decision was needed -->

**Decision:**
<!-- What was decided -->

**Consequences:**
<!-- What this means for the project -->

⸻

<!-- Add one section per decision -->
