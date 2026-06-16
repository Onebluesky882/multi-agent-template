# Multi-Agent AI Template

A starter template for running a project with a **Dev / Conductor / Worker** multi-agent workflow. Dev sets direction; the Conductor orchestrates stages and gates; each Worker owns exactly one pipeline stage, in its own branch, producing one PR.

## Authority Order

```
Dev  >  Conductor  >  Workers
```

- **Dev** — project owner/human lead. Sets direction, workflow, design conventions, and tech stack. Only Dev may pin package versions in `DECISIONS.md`.
- **Conductor** — orchestrates Workers: dispatches, validates gates, merges PRs. Must not act until QUESTIONS.md is fully answered.
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

## Setup — ทำก่อนเริ่ม pipeline

### Step 1 — Dev ตอบ QUESTIONS.md

เปิด `QUESTIONS.md` และตอบทุกคำถาม (29 ข้อ ใน 7 sections):

| Section | ครอบคลุม | อัพเดทไฟล์ |
|---------|---------|-----------|
| 1 — Project Identity | ชื่อ, core problem, target users | PROJECT.md |
| 2 — Tech Stack | ภาษา, framework, database, auth | DECISIONS.md |
| 3 — Architecture | รูปแบบ, modules, external services | ARCHITECTURE.md, CONTRACTS.md |
| 4 — Code Style | naming, linting, testing, TypeScript | DECISIONS.md |
| 5 — Pipeline & Stages | stages, dependencies, conductor-branch ⚠️ | PIPELINE.md |
| 6 — Roadmap | goals, vision, milestone | ROADMAP.md |
| 7 — Security | sensitive data, environments, compliance | SECURITY_RULES.md |

### Step 2 — Conductor อัพเดท governance files

Conductor อ่านคำตอบและอัพเดททุกไฟล์ตาม Conductor Instructions ใน `QUESTIONS.md`

### Step 3 — รัน Setup Test

รัน Setup Test ทั้ง 8 ข้อใน `QUESTIONS.md` เพื่อยืนยันว่า governance พร้อมใช้งาน

### PRE-FLIGHT CHECK (บังคับ)

ทั้ง Conductor และ Worker จะ `BLOCKED: PROJECT NOT CONFIGURED` ถ้ายังพบ `<conductor-branch>` เป็น literal placeholder:

```bash
grep -rn "<conductor-branch>" PIPELINE.md PROJECT.md AGENT_RULES.md README.md
```

ต้องไม่มี output — ถ้ามีให้กลับไป Step 1

---

## Required Reading Order (Workers)

ดู `GOVERNANCE_CORE.md` สำหรับ reading order ฉบับเต็ม (ไฟล์ 0–11)

---

## Running a stage (Conductor)

1. ยืนยันว่า PRE-FLIGHT CHECK ผ่านแล้ว
2. ยืนยันว่า `Depends On` stages ทั้งหมด `COMPLETE` และ merged แล้ว
3. เขียน `tasks/stage-[N]-<domain>.md` — stage number, domain, Depends On, model, context files, task description, `Gate-In Verified: YES`
4. ตั้ง `Status: IN_PROGRESS` ใน `PIPELINE.md`
5. Dispatch worker agent

Stages ที่ `Depends On: none` หรือ deps ครบ `COMPLETE` dispatch ได้พร้อมกัน (parallel)

---

## Running a stage (Worker)

1. อ่าน `START_HERE.md` — PRE-FLIGHT CHECK จะรันที่นี่
2. อ่านไฟล์ตาม reading order ใน `GOVERNANCE_CORE.md`
3. หา stage ที่ `Status: IN_PROGRESS` และยืนยันว่า `tasks/stage-[N]-<domain>.md` มี `Gate-In Verified: YES` — ถ้าไม่มี STOP → `BLOCKED: WAITING_FOR_GATE_IN`
4. Implement เฉพาะ assigned domain สร้าง branch `feature/[domain]`
5. ตรวจ version ก่อนติด package ทุกตัว — ดู Version Policy ด้านล่าง
6. รัน tests และ build verification
7. สร้าง `gate-out/stage-[N]-<domain>.md` ตาม template ใน `AGENT_RULES.md → Stage Completion`
8. STOP — ห้าม merge, ห้ามเริ่ม stage ถัดไป

---

## Gate validation (Conductor)

1. อ่าน `gate-out/stage-[N]-<domain>.md`
2. PASS เมื่อ: `status: PASS`, `ready_for_next: YES`, acceptance criteria ครบ, ไม่มี blocking issues, SECURITY_RULES.md ผ่าน
3. REJECT → เขียน `rejection/stage-[N]-<domain>.md` และ halt
4. PASS →
   - อัพเดท `PIPELINE.md` → Stage `[N]` = `COMPLETE`
   - เขียน `merge-approval/stage-[N]-<domain>.md`
   - หลัง squash-merge เข้า `<conductor-branch>` — unlock `PENDING` stages ที่ deps ครบ

---

## Version Policy

Workers ต้องตรวจ version จริงก่อน install ทุกครั้ง — ห้ามใช้ version จาก training data:

```bash
npm info <package> version   # Node
pip index versions <package> # Python
cargo search <package>       # Rust
```

Bootstrap ต้องใช้ `@latest` เสมอ:

```bash
npm create vite@latest
npx create-next-app@latest
npx create-expo-app@latest
```

**ยกเว้น:** package ที่อยู่ใน **Pinned Versions** table ใน `DECISIONS.md` — ใช้ version นั้นเป๊ะ ห้ามใช้ `@latest`
Pinned Versions แก้ได้เฉพาะ Dev เท่านั้น และต้อง log ใน `DEV_LOG.md`

---

## Dev direct edits

เมื่อ Dev แก้ไฟล์โดยตรง:
1. Dev เพิ่ม entry ใน `DEV_LOG.md`
2. Conductor อ่าน `DEV_LOG.md` และ reconcile `ROADMAP.md`, `PROJECT.md`, `PIPELINE.md`

---

## Conductor-only work

งานที่ต้องทำเอง (cross-stage integration, e2e tests, hardware access) — mark `Owner: CONDUCTOR` ใน `PIPELINE.md`

---

## ADRs

```bash
ls docs/adrs/ | sort | tail -3
```

เอา number สูงสุด +1 ตั้งชื่อ `NNN-short-slug.md` พร้อม header `# ADR NNN — Title`

---

## Key rules at a glance

- **Setup gate** — ตอบ QUESTIONS.md และผ่าน Setup Test ก่อนเริ่ม pipeline
- **PRE-FLIGHT** — `<conductor-branch>` เป็น placeholder → BLOCKED ทันที
- One stage = one branch = one PR = one merge into `<conductor-branch>`
- `COMPLETE` stage เป็น immutable — bug → new stage, ไม่ใช่ edit
- Workers ห้ามแก้ governance files ทุกไฟล์
- Version ต้องตรวจ runtime เสมอ — training-data version = ไม่น่าเชื่อถือ
- Security violation → `Status: FAIL`, `Ready For Next Stage: NO`
- ห้าม commit build artifacts (`node_modules/`, `dist/`, `build/`, `.next/`, `target/`, `__pycache__/`, `.venv/`, `vendor/`)

Full rules → `AGENT_RULES.md` | Authority model → `GOVERNANCE_CORE.md` | Setup → `QUESTIONS.md`
