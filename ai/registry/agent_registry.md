---
registry_id: REG-AGT-001
title: Master Agent Persona Registry
version: 1.0.0
owner: Chief AI Engineering Lead
last_updated: 2026-07-15
token_estimate: ~350 tokens
---

# Master Agent Persona Registry

This index lists all approved AI Agent Personas across FSP. AI bootstrap workflows should read this index first to locate the exact agent orchestrator file without loading every prompt into the context window.

| Agent Persona ID | Role Name | Domain Basket | Target File Path | Primary Capabilities |
| :--- | :--- | :--- | :--- | :--- |
| `AGT-ARCH-001` | **Chief Enterprise Architect** | `architecture` | `ai/domains/architecture/agents/chief_architect.md` | System design, C4 diagrams, ADR review, DDD boundaries |
| `AGT-BACK-001` | **Principal .NET Backend Dev** | `backend` | `ai/domains/backend/agents/backend_dev.md` | MediatR scaffolding, EF Core entities, CQRS handlers |
| `AGT-MOB-001` | **Principal Flutter Mobile Dev** | `flutter` | `ai/domains/flutter/agents/flutter_dev.md` | BLoC state management, Isar offline sync, UI widgets |
| `AGT-API-001` | **API & Integration Designer** | `api` | `ai/domains/api/agents/api_designer.md` | REST conventions, OpenAPI specs, payload validation |
| `AGT-DB-001` | **Database & Schema Architect** | `database` | `ai/domains/database/agents/db_architect.md` | SQL Server schemas, EF Core migrations, indexing |
| `AGT-QA-001` | **QA & Test Automation Lead** | `testing` | `ai/domains/testing/agents/qa_engineer.md` | Unit/Integration test scaffolding, E2E journeys |
| `AGT-OPS-001` | **DevOps & SRE Engineer** | `devops` | `ai/domains/devops/agents/devops_engineer.md` | CI/CD YAML, Docker multi-stage, Terraform IaC |
| `AGT-REV-001` | **Automated Code Reviewer** | `architecture` | `ai/domains/architecture/agents/ai_reviewer.md` | Automated PR verification against rules & graph |
