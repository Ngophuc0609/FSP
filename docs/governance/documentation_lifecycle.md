---
title: Documentation Lifecycle & Maintenance Policy
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# DOCUMENTATION LIFECYCLE & MAINTENANCE

## 1. The Living Documentation Rule
In `FSP`, documentation is treated with the same rigor as executable production code. Documentation drift (where code updates but `docs/` or `ai/knowledge_graph/` remains outdated) is considered a **High-Severity Technical Debt Defect**.

---

## 2. Automated Documentation Audit Workflow
Whenever an engineer or AI agent executes `ai/workflows/update_docs.md`:
1. The AI Reviewer checks if any public API endpoint signature changed without updating `docs/api/`.
2. The Database Architect checks if any EF Core migration added a column without updating `docs/database/erd.md`.
3. Any documentation discrepancy blocks the release pipeline until synchronized.
