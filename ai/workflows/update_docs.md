---
id: update_docs
title: Multi-Agent Workflow - Automated Documentation & Knowledge Sync
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates AI Reviewer and Domain Leads to keep docs/ synchronized with code changes.
---

# MULTI-AGENT WORKFLOW: DOCUMENTATION & KNOWLEDGE SYNC

This workflow ensures that whenever code, schemas, or APIs mutate, the corresponding technical documentation in `docs/` and `ai/knowledge_graph/` is automatically updated to prevent documentation drift.

---

## Workflow Execution Chain
1. **API Synchronization:** When controllers change, update `docs/api/swagger.json` and `docs/api/changelog.md`.
2. **Schema Synchronization:** When EF Core migrations run, update `docs/database/erd.md` and `docs/database/naming_convention.md`.
3. **Graph Synchronization:** When module boundaries shift, update `ai/knowledge_graph/master_graph.md`.
4. **Validation Gate:** Run documentation linters to verify zero broken markdown links and correct formatting.
