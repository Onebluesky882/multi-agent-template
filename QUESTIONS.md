QUESTIONS.md

Status: ACTIVE

Owner: CONDUCTOR

⸻

Purpose

ตอบคำถามทั้งหมดนี้ก่อนเริ่มใช้ template นี้กับโปรเจ็คจริง

Conductor จะนำคำตอบไปอัพเดทไฟล์ governance ที่เกี่ยวข้องโดยอัตโนมัติ

⸻

วิธีใช้

1. ผู้ใช้ตอบทุกคำถาม (ใส่คำตอบแทน [TBD])
2. แจ้ง Conductor ว่า QUESTIONS.md อัพเดทแล้ว
3. Conductor อ่านคำตอบและอัพเดทไฟล์ governance ตาม "→ อัพเดทไฟล์" ที่ระบุไว้

⸻

## Section 1 — Project Identity
→ อัพเดทไฟล์: PROJECT.md

Q1. ชื่อโปรเจ็คคืออะไร?

Answer: [TBD]

---

Q2. โปรเจ็คนี้ทำอะไร? (อธิบายสั้นๆ 1-3 ประโยค — core problem ที่แก้)

Answer: [TBD]

---

Q3. ผู้ใช้งานหลัก (target users) คือใคร?

Answer: [TBD]

---

Q4. สถานะปัจจุบันของโปรเจ็ค?

- [ ] Greenfield (เริ่มใหม่)
- [ ] Existing codebase (ต่อยอดของเดิม)
- [ ] Prototype (มี proof-of-concept แล้ว)

Answer: [TBD]

⸻

## Section 2 — Tech Stack
→ อัพเดทไฟล์: DECISIONS.md

Q5. ภาษาหลักที่ใช้?

Answer: [TBD]

---

Q6. Frontend framework?

ตัวอย่าง: Next.js, React, Vue, SvelteKit, React Native, Expo, ไม่มี (API-only)

Answer: [TBD]

---

Q7. Backend framework?

ตัวอย่าง: Express, Fastify, FastAPI, Django, NestJS, Hono, ไม่มี (frontend-only)

Answer: [TBD]

---

Q8. Database?

ตัวอย่าง: PostgreSQL, MySQL, MongoDB, SQLite, Supabase, PlanetScale, ไม่มี

Answer: [TBD]

---

Q9. Authentication / Authorization?

ตัวอย่าง: JWT, NextAuth, Clerk, Supabase Auth, Firebase Auth, OAuth2, ไม่มี

Answer: [TBD]

---

Q10. Deployment platform?

ตัวอย่าง: Vercel, Railway, AWS, GCP, Fly.io, Docker self-hosted

Answer: [TBD]

---

Q11. Package manager?

- [ ] npm
- [ ] yarn
- [ ] pnpm
- [ ] bun

Answer: [TBD]

⸻

## Section 3 — Architecture & Structure
→ อัพเดทไฟล์: ARCHITECTURE.md, CONTRACTS.md

Q12. รูปแบบ architecture คืออะไร?

ตัวอย่าง: Monolith, Monorepo (Turborepo/Nx), Microservices, Serverless, Full-stack SSR

Answer: [TBD]

---

Q13. โปรเจ็คแบ่งออกเป็น modules/domains อะไรบ้าง?

ตัวอย่าง: auth, user, product, payment, notification, admin

Answer: [TBD]

---

Q14. มี external services หรือ third-party APIs ที่ต้องใช้ไหม?

ตัวอย่าง: Stripe, SendGrid, Twilio, AWS S3, OpenAI API

Answer: [TBD]

---

Q15. โครงสร้าง folder ที่ต้องการ?

ตัวอย่าง:
```
src/
  app/        (Next.js App Router)
  components/
  lib/
  server/
```

Answer: [TBD]

⸻

## Section 4 — Code Style & Patterns
→ อัพเดทไฟล์: DECISIONS.md

Q16. Linting / Formatting tools?

ตัวอย่าง: ESLint + Prettier, Biome, Ruff (Python)

Answer: [TBD]

---

Q17. รูปแบบการตั้งชื่อ (naming conventions)?

ตัวอย่าง:
- Components: PascalCase
- Functions/variables: camelCase
- Files: kebab-case
- Constants: UPPER_SNAKE_CASE

Answer: [TBD]

---

Q18. Testing framework?

ตัวอย่าง: Vitest, Jest, Playwright, Cypress, pytest

Answer: [TBD]

---

Q19. State management (ถ้ามี frontend)?

ตัวอย่าง: Zustand, Jotai, Redux Toolkit, TanStack Query, Context API, ไม่มี

Answer: [TBD]

---

Q20. TypeScript ใช้ไหม?

- [ ] Yes — strict mode
- [ ] Yes — relaxed
- [ ] No

Answer: [TBD]

⸻

## Section 5 — Pipeline & Stages
→ อัพเดทไฟล์: PIPELINE.md

Q21. รายการ stages ที่ต้องการ build (เรียงตามลำดับ)?

ตัวอย่าง:
```
Stage 1 — setup       (project scaffold, config)
Stage 2 — auth        (login, register, session)
Stage 3 — user        (profile, settings)
Stage 4 — core        (main feature)
Stage 5 — api         (REST endpoints)
Stage 6 — ui          (pages, components)
Stage 7 — tests       (e2e, integration)
```

Answer: [TBD]

---

Q22. Stages ไหนทำพร้อมกันได้ (parallel)?

Answer: [TBD]

---

Q23. <conductor-branch> — branch name ที่ทุก PR จะ merge เข้า?

ตัวอย่าง: main, develop, conductor

Answer: [TBD]

⸻

## Section 6 — Roadmap & Goals
→ อัพเดทไฟล์: ROADMAP.md

Q24. เป้าหมายระยะสั้น (1-4 สัปดาห์)?

Answer: [TBD]

---

Q25. เป้าหมายระยะยาว (vision)?

Answer: [TBD]

---

Q26. Milestone แรกที่ถือว่า "done" คืออะไร?

ตัวอย่าง: MVP ที่ user login และใช้ core feature ได้

Answer: [TBD]

⸻

## Section 7 — Security & Environment
→ อัพเดทไฟล์: SECURITY_RULES.md

Q27. ข้อมูล sensitive ที่โปรเจ็คนี้จัดการ?

ตัวอย่าง: user PII, payment data, health records, ไม่มี

Answer: [TBD]

---

Q28. มี environment แยกกันไหม?

- [ ] dev / staging / production
- [ ] dev / production
- [ ] development only

Answer: [TBD]

---

Q29. มี compliance requirement พิเศษไหม?

ตัวอย่าง: PDPA, GDPR, PCI-DSS, HIPAA, ไม่มี

Answer: [TBD]

⸻

## Conductor Instructions

หลังจากผู้ใช้ตอบคำถามครบ ให้ Conductor:

1. PROJECT.md — อัพเดท: name, description, target users, status (จาก Q1–Q4)
2. DECISIONS.md — อัพเดท: tech stack ทั้งหมด, naming conventions, testing, code style (จาก Q5–Q20)
3. ARCHITECTURE.md — อัพเดท: architecture type, modules, external services, folder structure (จาก Q12–Q15)
4. CONTRACTS.md — สร้าง contract เบื้องต้นสำหรับแต่ละ module (จาก Q13–Q14)
5. PIPELINE.md — สร้าง stage list, Depends On, conductor-branch (จาก Q21–Q23)
6. ROADMAP.md — อัพเดท: goals, vision, milestone (จาก Q24–Q26)
7. SECURITY_RULES.md — เพิ่ม/แก้ไข rules ให้ตรงกับ sensitive data และ compliance (จาก Q27–Q29)
8. ทุก `<conductor-branch>` ใน AGENT_RULES.md, README.md — แทนด้วยชื่อ branch จริง (จาก Q23)
9. บันทึกการเปลี่ยนแปลงใน DEV_LOG.md

⸻

Status

- [ ] Section 1 — Project Identity: ยังไม่ตอบ
- [ ] Section 2 — Tech Stack: ยังไม่ตอบ
- [ ] Section 3 — Architecture: ยังไม่ตอบ
- [ ] Section 4 — Code Style: ยังไม่ตอบ
- [ ] Section 5 — Pipeline: ยังไม่ตอบ
- [ ] Section 6 — Roadmap: ยังไม่ตอบ
- [ ] Section 7 — Security: ยังไม่ตอบ
- [ ] Conductor updated all governance files: ยังไม่ทำ
