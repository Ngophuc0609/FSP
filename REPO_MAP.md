# Repository Structure & Navigation Map (`REPO_MAP.md`)

This document provides a detailed physical map and navigation instructions for the FSP repository. Both human engineers and AI assistants must use this map to locate files, understand module responsibilities, and maintain folder cleanliness.

---

## 1. Top-Level Physical Map

```text
D:\Workspace\work\FSP\
├── ai/                      # AI Operating System (AI Engineering Platform v2.0.0)
│   ├── AI_ENGINEERING_PLATFORM_DESIGN.md  # Official Architectural Blueprint & Decision Log
│   ├── constitution/        # [Phase 0] Supreme principles governing all AI behavior
│   ├── shared/              # [Tier 1 Project DNA] Universal Agent Header, rules & charter
│   ├── ontology/            # [Phase 0] Canonical domain dictionaries & definitions
│   ├── capabilities/        # [Phase 1] High-level capability matrix & inventory
│   ├── standards/           # [Phase 0] Base technical specifications
│   ├── governance/          # [Phase 0] CODEOWNERS, review gates, lifecycle rules
│   ├── registry/            # [Phase 0] Master lookup indices (~500 tokens)
│   ├── knowledge_graph/     # [Phase 0] Relational impact matrices & Mermaid diagrams
│   ├── domains/             # [Phase 1] Domain-Bounded Baskets
│   │   ├── architecture/    # Architectural rules, skills, agents & prompts
│   │   ├── backend/         # .NET backend rules, skills, agents & prompts
│   │   ├── flutter/         # Flutter mobile rules, skills, agents & prompts
│   │   ├── api/             # REST API rules, skills, agents & prompts
│   │   ├── database/        # Database schema/migration rules & skills
│   │   ├── testing/         # QA automation, unit/e2e test skills & rules
│   │   └── devops/          # CI/CD, IaC, and SRE skills & rules
│   ├── playbooks/           # [Phase 2] SOP step-by-step execution guides
│   ├── workflows/           # [Phase 2] Multi-agent DAG orchestration scripts
│   ├── evaluation/          # [Phase 2] Automated linters, benchmarks & validation gates
│   ├── memory/              # [Phase 3] Continuous learning stores
│   │   ├── adr/             # Architecture Decision Records
│   │   ├── lessons/         # Post-mortem & lesson logs
│   │   └── retrospectives/  # Sprint retrospectives & anti-pattern reports
│   └── templates/           # [Phase 0] YAML/Markdown templates for scaffolding
├── docs/                    # Human & AI co-authored project documentation
│   ├── business/            # BRDs, PRDs, user personas, operational SLAs
│   ├── architecture/        # High-level architecture diagrams, C4 models
│   ├── api/                 # OpenAPI/Swagger specs, Postman collections
│   ├── database/            # ERD diagrams, schema documentation
│   ├── testing/             # Test plans, QA strategies, coverage reports
│   └── devops/              # Deployment guides, infrastructure diagrams, runbooks
├── src/                     # Application Source Code
│   ├── backend/             # .NET Core 8+ Clean Architecture Solution
│   │   ├── FSP.Domain/      # Pure domain entities, value objects, invariants
│   │   ├── FSP.Application/ # MediatR handlers, DTOs, CQRS, validation
│   │   ├── FSP.Infrastructure/ # EF Core DbContext, repositories, external services
│   │   └── FSP.Api/         # REST API Controllers & Minimal API endpoints
│   ├── flutter/             # Flutter Mobile App (Field Technician Client)
│   │   ├── lib/             # Dart source code (BLoC, Screens, Repositories)
│   │   └── test/            # Unit, Widget, and Integration tests
│   └── web/                 # Web Management Portal
├── REPO_MAP.md              # This file
└── README.md                # Root entry point & AI bootstrap protocol
```

---

## 2. AI Navigation Rules by Task Type

| Task Type | Target Read Directory | Target Write Directory | Mandatory Standard / Rule Check |
| :--- | :--- | :--- | :--- |
| **New Feature Scaffolding (.NET)** | `ai/ontology/`, `ai/standards/ddd_standard.md`, `ai/domains/backend/skills/` | `src/backend/FSP.Domain/`, `src/backend/FSP.Application/` | `RULE-DDD-001`, `RULE-NAME-001` |
| **New Screen Scaffolding (Flutter)** | `ai/ontology/`, `ai/standards/flutter_standard.md`, `ai/domains/flutter/skills/` | `src/flutter/lib/` | `RULE-FLUTTER-001`, `RULE-NAME-001` |
| **Database Schema Mutation** | `ai/knowledge_graph/master_graph.md`, `ai/ontology/business.md` | `src/backend/FSP.Infrastructure/Migrations/` | `RULE-ARCH-001`, `RULE-NAME-002` |
| **API Endpoint Creation** | `ai/standards/rest_standard.md`, `ai/domains/api/skills/` | `src/backend/FSP.Api/Controllers/` | `RULE-API-001`, `STD-REST-001` |
| **Code Review / Audit** | `ai/governance/review_process.md`, `ai/domains/<domain>/rules/` | `ai/memory/lessons/` (if anti-pattern found) | `GOV-REV-001` |
