---
registry_id: REG-SKL-001
title: Master Skill Registry
version: 2.0.0
owner: Chief AI Engineering Lead
last_updated: 2026-07-15
token_estimate: ~500 tokens
---

# Master Skill Registry

This index lists all modular instructional Skills across FSP. AI agents must inject relevant skills during execution based on task requirements.

| Skill ID | Skill Name | Domain Basket | Target File Path | Description & Trigger Context |
| :--- | :--- | :--- | :--- | :--- |
| `SKL-ARCH-001` | **Architecture Review** | `architecture` | `ai/domains/architecture/skills/Skill-Architecture-Review.md` | Evaluating PRs and schemas against Clean Architecture and ADRs |
| `SKL-BACK-001` | **Design Backend Module** | `backend` | `ai/domains/backend/skills/Skill-Design-Backend-Module.md` | Scaffolding MediatR Command/Query handlers and DTOs with FluentValidation |
| `SKL-MOB-001` | **Build Flutter Screen** | `flutter` | `ai/domains/flutter/skills/Skill-Build-Flutter-Screen.md` | Scaffolding Riverpod `AsyncNotifierProvider` and offline-first `ConsumerWidget` |
| `SKL-DB-001` | **Design Database Schema** | `database` | `ai/domains/database/skills/Skill-Design-Database-Schema.md` | Scaffolding `BaseTenantEntity`, composite indexes, and EF Core configuration |
| `SKL-QA-001` | **Write QA Test Suite** | `testing` | `ai/domains/testing/skills/Skill-Write-QA-Test.md` | Scaffolding `AAA` pattern `xUnit` and `Testcontainers.MsSql` integration tests |
| `SKL-OPS-001` | **Setup DevOps Pipeline** | `devops` | `ai/domains/devops/skills/Skill-Setup-DevOps-Pipeline.md` | Scaffolding GitHub Actions CI/CD workflows and multi-stage Alpine Dockerfiles |
| `SKL-BA-001` | **Write PRD/BRD Spec** | `business` | `ai/domains/business/skills/Skill-Write-PRD.md` | Authoring canonical requirements specifications and state transition diagrams |
| `SKL-UI-001` | **Design UI Tokens** | `design` | `ai/domains/design/skills/Skill-Design-UI-Tokens.md` | Scaffolding high-contrast design system tokens and ergonomic wireframes |
