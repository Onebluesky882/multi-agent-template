QUESTIONS.md

Status: ACTIVE

Owner: CONDUCTOR

⸻

Purpose

เก็บข้อมูลที่ Conductor ต้องรู้ก่อนเริ่ม pipeline
Conductor จะถามทีละข้อ รอคำตอบ แล้วเสนอ recommendation สำหรับส่วนที่เหลือ

⸻

วิธีใช้ — Conductor-led Setup

กฎสำหรับ Conductor:
1. ถามทีละข้อเท่านั้น — ห้ามถามหลายข้อพร้อมกัน
2. รอคำตอบก่อนถามข้อถัดไป
3. หลังได้คำตอบ Q1–Q4: เสนอ Tech Stack Recommendation แทนที่จะถาม Q5–Q11 ทีละข้อ
4. Dev ยืนยัน หรือบอกสิ่งที่ต้องการเปลี่ยน
5. บันทึกคำตอบทั้งหมดลงไฟล์นี้ก่อนอัพเดท governance files

รูปแบบการถาม:
> **[Q1]** ชื่อโปรเจ็คคืออะไร?

⸻

## Part 1 — สิ่งที่เฉพาะ Dev รู้ (ต้องถาม)
→ ถามทีละข้อ Q1 → Q6

Q1. ชื่อโปรเจ็คคืออะไร?

Answer: [TBD]

---

Q2. โปรเจ็คนี้ทำอะไร และ target users คือใคร?
(อธิบายสั้นๆ — core problem + คนที่ใช้งาน)

Answer: [TBD]

---

Q3. ประเภทโปรเจ็ค?

- [ ] Web full-stack (frontend + backend)
- [ ] Web frontend-only
- [ ] API / Backend-only
- [ ] Mobile (iOS/Android)
- [ ] อื่นๆ: ___

Answer: [TBD]

---

Q4. สถานะปัจจุบัน?

- [ ] Greenfield (เริ่มใหม่)
- [ ] Existing codebase (ต่อยอดของเดิม)
- [ ] Prototype (มี proof-of-concept แล้ว)

Answer: [TBD]

---

Q5. conductor-branch — branch name ที่ทุก PR จะ merge เข้า? ⚠️ BLOCKING

ตัวอย่าง: main, develop, conductor

> Conductor และ Worker จะ BLOCKED จนกว่าจะได้คำตอบข้อนี้

Answer: [TBD]

---

Q6. Pipeline stages ที่ต้องการ build มีอะไรบ้าง? (เรียงตามลำดับ)

ตัวอย่าง:
```
Stage 1 — setup    (scaffold, config)
Stage 2 — auth     (login, register)
Stage 3 — core     (main feature)
Stage 4 — ui       (pages, components)
Stage 5 — tests    (e2e, integration)
```

Answer: [TBD]

⸻

## Part 2 — Tech Stack Recommendation (Conductor เสนอ)

หลังได้คำตอบ Q1–Q4 ให้ Conductor:

1. เสนอ recommendation ตาม template ด้านล่าง
2. ถาม Dev ว่า "ต้องการเปลี่ยนอะไรไหม?"
3. บันทึกที่ตกลงกันลงใน Answer ด้านล่าง

---

### Recommendation Templates (Conductor เลือกตาม Q3)

**Web full-stack:**
```
แนะนำ:
- Language:     TypeScript (strict)
- Frontend:     Next.js (App Router)
- Backend:      Next.js API Routes / Hono
- Database:     PostgreSQL + Prisma
- Auth:         NextAuth v5
- Deployment:   Vercel
- Package mgr:  pnpm
- Linting:      ESLint + Prettier
- Testing:      Vitest + Playwright
- State:        TanStack Query
- Naming:       Components PascalCase, functions camelCase, files kebab-case
```

**Web frontend-only:**
```
แนะนำ:
- Language:     TypeScript (strict)
- Frontend:     Next.js (App Router) หรือ Vite + React
- Deployment:   Vercel / Netlify
- Package mgr:  pnpm
- Linting:      ESLint + Prettier
- Testing:      Vitest + Playwright
- State:        TanStack Query + Zustand
- Naming:       Components PascalCase, functions camelCase, files kebab-case
```

**API / Backend-only:**
```
แนะนำ:
- Language:     TypeScript (strict)
- Backend:      Hono หรือ Fastify
- Database:     PostgreSQL + Prisma
- Auth:         JWT
- Deployment:   Railway / Fly.io
- Package mgr:  pnpm
- Linting:      ESLint + Prettier
- Testing:      Vitest
- Naming:       functions camelCase, files kebab-case
```

**Mobile:**
```
แนะนำ:
- Language:     TypeScript (strict)
- Framework:    Expo (React Native)
- Backend:      Hono (separate service)
- Auth:         Clerk หรือ Supabase Auth
- Package mgr:  pnpm
- Linting:      ESLint + Prettier
- Testing:      Jest
- State:        Zustand + TanStack Query
```

---

### Agreed Tech Stack

(Conductor บันทึกที่นี่หลัง Dev ยืนยัน)

Answer: [TBD]

⸻

## Conductor Instructions

หลังจาก Dev ตอบครบและยืนยัน Tech Stack แล้ว ให้ Conductor:

1. PROJECT.md — อัพเดท: name, description, target users, status (จาก Q1–Q4)
2. DECISIONS.md — อัพเดท: tech stack ทั้งหมด, naming conventions, testing, code style (จาก Agreed Tech Stack)
3. ARCHITECTURE.md — อัพเดท: architecture type, folder structure ที่เหมาะกับ stack
4. CONTRACTS.md — สร้าง contract เบื้องต้นตาม stages ใน Q6
5. PIPELINE.md — สร้าง stage list, Depends On, conductor-branch (จาก Q5–Q6)
6. ROADMAP.md — อัพเดท: goals และ milestone แรกจาก Q2 + Q6
7. SECURITY_RULES.md — เพิ่ม rules ตาม project type และ data sensitivity ที่ระบุใน Q2
8. ทุก `<conductor-branch>` ใน AGENT_RULES.md, README.md — แทนด้วยชื่อจริง (จาก Q5)
9. บันทึกการเปลี่ยนแปลงใน DEV_LOG.md

⸻

Status

- [ ] Q1–Q6 ตอบครบ
- [ ] Tech Stack ยืนยันแล้ว
- [ ] Conductor updated all governance files
- [ ] Setup Test PASSED

⸻

## Setup Test — รันหลัง Conductor อัพเดท governance ครบแล้ว

ผ่านทุกข้อ = เริ่ม pipeline ได้

---

### T1 — ไม่มี placeholder หลงเหลือ

```bash
grep -rn "\[TBD\]\|<conductor-branch>\|\[name\]\|\[N\]" \
  PROJECT.md ROADMAP.md ARCHITECTURE.md CONTRACTS.md \
  DECISIONS.md PIPELINE.md SECURITY_RULES.md AGENT_RULES.md README.md
```

ผล: ต้องไม่มี output

Result: [ ] PASS / [ ] FAIL

---

### T2 — conductor-branch มีอยู่จริงใน git

```bash
git branch -a | grep -F "<ใส่ชื่อ conductor-branch จริงที่ตอบใน Q5>"
```

ผล: ต้องพบ branch นั้น — ถ้าไม่พบให้ Conductor สร้าง branch ก่อน

Result: [ ] PASS / [ ] FAIL

---

### T3 — PROJECT.md มีข้อมูลจริง

ตรวจสอบด้วยตา:
- [ ] มีชื่อโปรเจ็คจริง
- [ ] มี description อธิบาย core problem
- [ ] มี target users
- [ ] มี status ปัจจุบัน

Result: [ ] PASS / [ ] FAIL

---

### T4 — DECISIONS.md มี tech stack ครบ

ตรวจสอบด้วยตา:
- [ ] ภาษาหลัก
- [ ] Frontend / Backend framework (หรือระบุว่าไม่มี)
- [ ] Database (หรือระบุว่าไม่มี)
- [ ] Authentication method
- [ ] Package manager
- [ ] Testing framework
- [ ] Linting/formatting tools
- [ ] Naming conventions

Result: [ ] PASS / [ ] FAIL

---

### T5 — PIPELINE.md มี stages จริง

```bash
grep -c "Stage\|PENDING\|IN_PROGRESS" PIPELINE.md
```

ผล: ต้องได้ค่ามากกว่า 0

ตรวจสอบด้วยตา:
- [ ] มี stage อย่างน้อย 1 stage
- [ ] ทุก stage มี `Depends On` ระบุ
- [ ] `<conductor-branch>` ถูกแทนด้วยชื่อจริงแล้ว

Result: [ ] PASS / [ ] FAIL

---

### T6 — ARCHITECTURE.md และ CONTRACTS.md ไม่ว่างเปล่า

```bash
wc -l ARCHITECTURE.md CONTRACTS.md
```

ผล: ทั้งสองไฟล์ต้องมีมากกว่า 10 บรรทัด

Result: [ ] PASS / [ ] FAIL

---

### T7 — DEV_LOG.md มี entry บันทึกการ setup

ตรวจสอบด้วยตา:
- [ ] มีอย่างน้อย 1 entry ที่บันทึกการอัพเดท governance จาก QUESTIONS.md

Result: [ ] PASS / [ ] FAIL

---

### T8 — Worker simulation

Conductor ส่ง prompt นี้ให้ Worker agent ใหม่:

> "อ่าน START_HERE.md แล้วรายงานว่าโปรเจ็คนี้คือโปรเจ็คอะไร tech stack คืออะไร และ stage แรกที่ต้องทำคืออะไร"

ผล Worker ต้องตอบได้ถูกต้องโดยไม่ต้องถาม Dev:
- [ ] Worker ตอบชื่อโปรเจ็คถูก
- [ ] Worker ตอบ tech stack ถูก
- [ ] Worker ระบุ stage แรกได้
- [ ] Worker ไม่ติด BLOCKED

Result: [ ] PASS / [ ] FAIL

---

### Test Summary

| Test | Result |
|------|--------|
| T1 — ไม่มี placeholder | |
| T2 — conductor-branch มีใน git | |
| T3 — PROJECT.md ครบ | |
| T4 — DECISIONS.md ครบ | |
| T5 — PIPELINE.md ครบ | |
| T6 — ARCHITECTURE.md / CONTRACTS.md ไม่ว่าง | |
| T7 — DEV_LOG.md มี entry | |
| T8 — Worker simulation | |

ผ่านทั้งหมด → อัพเดท Status checklist ด้านบน แล้วเริ่ม pipeline ได้

มี FAIL → แก้ไขและรัน test นั้นซ้ำก่อนเริ่ม pipeline
