# Field Service Platform (FSP) - AI Operating System (AIOS) Design

This document details the complete Enterprise AI Operating System (AIOS) framework for the FSP repository. It is a vendor-neutral, highly modular, and extensible system designed to allow multiple AI assistants (ChatGPT, Claude, Copilot, Cursor, etc.) to collaborate consistently over a 5–10 year lifespan.

---

## Reasoning Process (Think Before Generating)

1. **Disciplines Identified**: Product, Business, Architecture, Database, Backend, Frontend, Flutter, API, Testing, DevOps, Security, Cloud, AI, Documentation, Ops, Knowledge Management, Governance.
2. **Roles Identified**: Product Owner, BA, Solution Architect, DB Developer, Backend Dev, Flutter Dev, QA, SRE, Tech Writer, AI Orchestrator, etc.
3. **Responsibilities**: e.g., Define features, draft schema, write APIs, code UI, write tests, maintain CI/CD, review code, update ADRs.
4. **Capabilities**: e.g., `Cap-API-Design`, `Cap-DB-Migration`, `Cap-Flutter-State`.
5. **Skills**: Modular units like `Skill-Write-REST-Spec`, `Skill-Optimize-SQL`.
6. **Rules**: `Rule-CQRS-Enforcement`, `Rule-Clean-Architecture`.
7. **Templates**: `Template-ADR`, `Template-PRD`.
8. **Prompts**: `Prompt-Generate-API-Spec` which dynamically references the Rules, Skills, and Templates.
9. **Governance**: Defines ownership, lifecycle, and review cadences.
10. **Hierarchy**: A tree that physicalizes this ontology into a Git filesystem.

---

## 1. Repository Hierarchy

Every directory has a purpose. Every directory contains a `README.md` defining its owner and rules.

```text
FSP/
├── .github/                # Automation and CI/CD pipelines
├── aios/                   # The AI Operating System Core
│   ├── ontology/           # Definitions of domains and concepts
│   ├── capabilities/       # Capability Matrix
│   ├── skills/             # Reusable AI Skills (.md files)
│   ├── rules/              # Modular rule definitions
│   ├── contexts/           # Context packages for AI loading
│   ├── prompts/            # Bootstrapping and execution prompts
│   ├── workflows/          # DAG-based AI collaboration flows
│   ├── memory/             # Persistent AI memory (ADRs, Glossary)
│   ├── templates/          # Structural templates
│   └── governance/         # Policies and standards
├── docs/                   # Human and Machine readable project docs
│   ├── business/
│   ├── architecture/
│   ├── api/
│   └── database/
├── src/                    # Application source code
│   ├── backend/
│   ├── flutter/
│   └── web/
└── REPO_MAP.md
```

---

## 2. Ontology

The Software Engineering Ontology defines the universal language for the FSP project.

*   **Business**: Product Vision, PRD, BRD, User Stories, Epic, Acceptance Criteria.
*   **Architecture**: Domain-Driven Design (DDD), Clean Architecture, CQRS, Microservices, Event Sourcing.
*   **Database**: ERD, Migrations, Indexes, Relational Modeling, NoSQL Caching.
*   **Backend**: .NET, MediatR, Controllers, Handlers, Repositories, Dependency Injection.
*   **Frontend/Flutter**: BLoC/Provider, Widgets, Screens, Routing, Offline-First Sync.
*   **API**: REST, GraphQL, JWT Auth, OpenAPI, Webhooks.
*   **Testing**: Unit, Integration, E2E, UI, Mocking.
*   **DevOps/Cloud**: Docker, Kubernetes, CI/CD, Terraform, Azure/AWS.
*   **Security**: OWASP, RBAC, Encryption, Data Masking.
*   **AI/Knowledge**: Prompts, Skills, Memory, ADRs, Lessons Learned.
*   **Governance**: Ownership, Lifecycle, Versioning, Deprecation.

---

## 3. Capability Matrix

Capabilities represent the "What" the system or team can do.

**Example: `Cap-API-Design`**
*   **Name**: REST API Design
*   **Purpose**: Design robust, versioned, secure RESTful APIs.
*   **Owner Roles**: API Designer, Backend Architect.
*   **Required Skills**: `Skill-Write-OpenAPI`, `Skill-Define-REST-Codes`.
*   **Required Context**: `Context-API-Standards`, `Context-Domain-Model`.
*   **Required Templates**: `Template-OpenAPI-Spec`.
*   **Required Rules**: `Rule-URI-Naming`, `Rule-Standard-Errors`.
*   **Outputs**: `swagger.yaml`, `api_contract.md`.
*   **Dependencies**: `Cap-Business-Analysis`, `Cap-Database-Design`.
*   **Success Criteria**: Passes linting, reviewed by Frontend team.
*   **Evaluation Metrics**: 0 breaking changes without version bump, 100% typed responses.

---

## 4. Skill Library (`/aios/skills/`)

Skills define "How" an AI executes a capability. To ensure Agents know *when* and *how to prioritize* their abilities, skills are categorized into **AI Skill Levels**:

### 4.1 AI Skill Levels
*   **Foundation Skills**: Basic abilities required for all agents (e.g., `Analyze Requirement`, `Read Context`, `Write Markdown`, `Follow Naming Convention`).
*   **Core Engineering Skills**: Domain-specific implementation skills (e.g., `Design REST API`, `Design Database`, `Flutter Feature Design`, `Backend Module Design`).
*   **Review Skills**: Quality control and auditing skills (e.g., `Architecture Review`, `Security Review`, `Performance Review`, `Documentation Review`).
*   **Decision Skills**: Analytical skills for choices and trade-offs (e.g., `Create ADR`, `Impact Analysis`, `Risk Assessment`, `Trade-off Analysis`).
*   **Automation Skills**: Repetitive generation and sync tasks (e.g., `Generate Backlog`, `Generate Test Cases`, `Generate Release Notes`, `Synchronize Knowledge`).

### 4.2 Skill Definition Format
**Example: `Skill-Review-PR` (Level: Review Skills)**
*   **Metadata**: Version 1.0, Owner: QA/Architecture.
*   **Purpose**: Review code for style, security, and architectural compliance.
*   **Applicable Roles**: AI Reviewer, Software Architect.
*   **Required Context**: `Context-Clean-Arch`, `Context-PR-Diff`.
*   **Required Inputs**: PR Diff, Target Branch, Associated Jira Ticket.
*   **Expected Outputs**: Inline comments, Summary Review, Approval/Rejection.
*   **Execution Steps**: 
    1. Load Diff. 2. Verify against `Rule-Clean-Architecture`. 3. Check test coverage. 4. Format output.
*   **Checklist**: No hardcoded secrets? No business logic in controllers?
*   **Quality Rules**: `Rule-Constructive-Feedback`.
*   **Prompt Skeleton**: `[Load PR] -> [Apply Rules] -> [Output Feedback]`
*   **Anti-patterns**: Merging without tests, nitpicking formatting (rely on linter instead).

---

## 5. Rule Library (`/aios/rules/`)

Modular, reusable constraints. Never hardcode rules in prompts.

**Example Categories:**
*   **Architecture Rules**: `Rule-Strict-Dependency-Injection`, `Rule-No-Cross-Domain-Reads`.
*   **Flutter Rules**: `Rule-Stateless-Widgets-Preferred`, `Rule-BLoC-State-Immutability`.
*   **API Rules**: `Rule-Plural-Nouns-In-URI`, `Rule-ISO8601-Dates`.

**Rule Format (`Rule-CQRS-Enforcement`):**
*   **Identifier**: R-ARCH-001
*   **Category**: Architecture
*   **Description**: Commands must mutate state and return void/ID. Queries must not mutate state and return DTOs.
*   **Applies To**: Backend Code, API Design.
*   **Severity**: Critical (Blocker).
*   **Required Before**: Implementation, Code Review.
*   **Exceptions**: Logging mechanisms during Queries.

---

## 6. Context Library (`/aios/contexts/`)

Contexts define precisely what files an AI must load to understand a domain.

**Example: `Context-Flutter-Core`**
*   **Purpose**: Bootstraps an AI to write Flutter UI.
*   **Files to Load**: `/aios/rules/flutter_rules.md`, `/docs/architecture/flutter_architecture.md`, `/src/flutter/pubspec.yaml`.
*   **Priority**: High.
*   **Maximum Scope**: 5000 tokens.
*   **Reusable Across**: `Workflow-Create-Screen`, `Workflow-Fix-UI-Bug`.

---

## 7. Prompt Library (`/aios/prompts/`)

Prompts orchestrate Skills, Rules, and Contexts. They contain zero embedded logic.

**Example: `Prompt-Draft-ADR`**
```text
System: You are an Enterprise Architect.
Context: Load {Context-Architecture}
Skill: Apply {Skill-Draft-ADR}
Rules: Enforce {Rule-Markdown-Formatting}, {Rule-ADR-Structure}
Template: Use {Template-ADR}

Task: Based on the provided meeting notes, generate an ADR for adopting gRPC for microservice communication.
```

---

## 8. Workflow Library (`/aios/workflows/`)

DAG-based multi-agent collaboration flows.

**Example: `Workflow-Create-Feature`**
1.  **Step 1 (BA Agent)**: Execute `Prompt-Generate-PRD` using `Context-Business`. Output: `prd.md`.
2.  **Step 2 (Arch Agent)**: Read `prd.md`, execute `Prompt-System-Design`. Output: `system_design.md`.
3.  **Step 3 (API Agent)**: Read `system_design.md`, apply `Skill-Write-OpenAPI`. Output: `api_spec.yaml`.
4.  **Step 4 (Backend/Flutter Agents)**: Parallel execution of code generation based on `api_spec.yaml`.
5.  **Step 5 (QA Agent)**: Read code, apply `Skill-Generate-Tests`.

---

## 9. Memory Library (`/aios/memory/`)

Persistent storage allowing the AI OS to learn over time.

*   `architecture_memory.md`: Log of major refactoring decisions.
*   `glossary.md`: Universal terminology mapping.
*   `known_issues.md`: Contextual limitations for AI to avoid re-diagnosing known bugs.
*   `lessons_learned.md`: Anti-patterns discovered during the project's lifetime.
*   `adr/`: Formal Architecture Decision Records.

---

## 10. Governance (`/aios/governance/`)

The constitution of the repository.

*   **Folder Standards**: All lowercase, snake_case.
*   **Naming Standards**: PascalCase for C#, camelCase for Dart, snake_case for Python/AIOS files.
*   **Ownership**: Defined via `CODEOWNERS` and directory `README.md`.
*   **Review Process**: AI review -> Human review -> Merge.
*   **Deprecation Policy**: Old rules/skills move to `/aios/archive/`.
*   **AI Collaboration Policy**: An AI must cite the Rules and Skills it used when opening a PR.

---

## 11. Suggested Implementation Order

1.  **Phase 1: Foundation (Ontology & Governance)**
    *   Initialize the `/aios/ontology` and `/aios/governance`. Set up naming and standards.
2.  **Phase 2: Rules & Templates**
    *   Define the core architectural and coding rules. Create markdown templates.
3.  **Phase 3: Skills & Capabilities**
    *   Map out what the AI will do. Write the Skill markdown files.
4.  **Phase 4: Contexts & Prompts**
    *   Create the contextual loaders and the prompt wrappers.
5.  **Phase 5: Workflows & Memory**
    *   Define multi-step pipelines and initialize the memory logs (ADRs, Glossary).

---

## 12. Future Extension Strategy

*   **Dynamic Rule Enforcement**: Create a pre-commit hook that uses an LLM to evaluate code specifically against the `Rule Library` before allowing a commit.
*   **Automated Skill Generation**: As human developers solve novel problems, use a prompt to automatically extract the solution and write a new `Skill` file into `/aios/skills/`.
*   **Cross-Repository AIOS**: Abstract the `/aios` folder into a git submodule so it can be shared across multiple enterprise repositories beyond FSP.
*   **Memory Vectorization**: In 1-2 years, when the memory folder grows massive, implement an automated script that chunks and uploads `/aios/memory/` into a vector database for RAG-based context retrieval.
