# AI Engineering Platform (AIOS) - Enterprise Architecture & Design Document

**Repository:** FSP (Field Service Platform)  
**Version:** 2.0.0  
**Status:** Approved & Validated (via `/brainstorming`)  
**Target Lifespan:** 5–10 Years  
**Core Architecture:** Domain-Bounded Baskets + Phase-Oriented Layered Dependency

---

## 1. Understanding Summary

*   **What is being built:** An enterprise-grade **AI Engineering Platform (AIOS)** within the FSP repository, structured across **4 Implementation Phases** and **16+ tightly integrated ontology/runtime modules** under a single `ai/` root directory.
*   **Why it exists:** To transition from simple prompt-engineering to a standardized, highly modular, vendor-neutral AI software engineering ecosystem that eliminates hallucinations, enforces strict architectural/coding standards, and maintains automated dependency injection and impact tracking over a 5–10 year lifespan.
*   **Who it is for:** Human software engineers, system architects, technical leads, and multi-vendor AI assistants (Claude Code, Cursor, Copilot, ChatGPT, Gemini, and open-source/local LLMs like Llama 3, DeepSeek, Qwen).
*   **Key constraints:** Pure Markdown + YAML Frontmatter format (100% Git-native, no running background database required); Bootstrapping context limited to 8,000–12,000 tokens; Strict Governance where Phase 0 & Phase 1 require human architect approval; Local LLM compatible instruction clarity.
*   **Explicit non-goals:** No proprietary/vendor-specific locking syntax; No hardcoded business or implementation logic inside Prompts (Prompts only orchestrate context/skills/rules); No direct code generation before Phase 0 (Foundation) and Phase 1 (AI Core) are established; No storage of secrets or PII in memory/knowledge graph.

---

## 2. Assumptions

1.  **Directory Root:** The existing `aios/` folder will be consolidated into `ai/` (`aios/rules` -> `ai/rules`, `aios/skills` -> `ai/skills`, removing `aios/`). The `ai/` directory serves as the Single Source of Truth for the entire AI Engineering Platform.
2.  **Hybrid Registry:** Registries (`ai/registry/*.md`) operate as compact master indices (~500 tokens) listing entity IDs, names, domains, paths, and tags for rapid AI Dependency Injection, while detailed metadata resides inside each entity's YAML Frontmatter.
3.  **Dual Knowledge Graph:** The Knowledge Graph (`ai/knowledge_graph/*.md`) combines distributed frontmatter metadata inside entity files with centralized module-level relationship matrices and Mermaid diagrams to enable real-time Impact Analysis (`Feature -> Business Rule -> API -> Database -> UI -> Permission -> Notification -> Sync -> Test`).
4.  **Machine-Readable Rules:** Rules follow a strict YAML schema (`id, title, severity, category, required_before, required_after, violation_condition`) so automated evaluation engines and linter scripts can verify code deterministically.
5.  **Local LLM Compatibility:** All skills, rules, and prompts are authored with high structural clarity, clear chunking, and concise step-by-step instructions to ensure compatibility with local/open-source models (Llama 3, DeepSeek, Qwen).

---

## 3. Decision Log

| ID | Decision Item | Selected Option | Alternatives Considered | Rationale |
| :--- | :--- | :--- | :--- | :--- |
| **DEC-01** | **Storage & Query Model** | 100% Markdown + YAML Frontmatter in Git filesystem | Hybrid CLI Indexer (SQLite/JSON); Pure JSON/JSON-LD data structures | Keeps the repo vendor-neutral, easily diffable in PRs, and instantly searchable via `ripgrep`, `ast-grep`, or native AI workspace search without requiring running background databases. |
| **DEC-02** | **Knowledge Graph Linkage Pattern** | Dual Model (Distributed Frontmatter + Centralized Graph Views) | Distributed Frontmatter Only; Centralized Graph Registry Only | Provides both micro-context when an AI works on a specific file and macro-context (Mermaid graphs & impact matrices in `ai/knowledge_graph/`) for comprehensive Impact Analysis across modules. |
| **DEC-03** | **Directory Structure & Root Consolidation** | Single Root `ai/` with Domain-Bounded Baskets Layout | Phase-Oriented Flat Hierarchy under `ai/`; Package-Driven Runtime Layout | Domain-Bounded Baskets (`ai/domains/<domain>/`) isolate skills, rules, contexts, and agents by discipline (`backend`, `flutter`, `api`, `architecture`), preventing clutter while keeping shared foundational standards at the `ai/` root. |
| **DEC-04** | **Registry & Dependency Injection** | Hybrid Model (Master Index + Dynamic YAML Lookup) | Static Registry Index Only; Dynamic Search Schema Only | Master indices (`agent_registry.md`, `skill_registry.md`) give AI assistants a rapid, ~500-token catalog of available capabilities without bloating context window, allowing targeted injection of specific frontmatter details. |
| **DEC-05** | **Non-Functional Requirements (NFRs)** | Enterprise NFRs + Local LLM Compatibility | Frontier LLM Only optimization; Aggressive context budget limit (<5k tokens) | Ensures a long lifespan (5–10 years) across proprietary and open-source models while maintaining high performance, strict governance (CODEOWNERS), and zero-tolerance for secret leakage. |

---

## 4. Final Architecture & Directory Layout

### 4.1 Global Foundation vs Domain Baskets Layout

```text
ai/
├── constitution/       # Supreme AI Constitution & immutable principles
├── ontology/           # Standardized domain vocabulary (business, architecture, devops...)
├── standards/          # Root standards (Markdown, REST, DDD, Git, Folder...)
├── governance/         # Policies, Ownership rules (CODEOWNERS, Lifecycle)
├── registry/           # Hybrid Master Indices (~500 tokens) for AI Dependency Injection
├── knowledge_graph/    # Global relationship matrices & module-level Mermaid diagrams
├── memory/             # Global architectural memory (ADR, Lessons, Retrospectives)
├── evaluation/         # Shared evaluation frameworks & anti-pattern verification metrics
├── templates/          # Standardized Markdown/YAML templates for all entity types
├── workflows/          # Multi-agent DAG workflows (create_feature, release_version...)
├── playbooks/          # SOPs for AI (Bug Fix, Hotfix, PR Review, Migration, Incident...)
│
└── domains/            # Bounded Baskets - Discipline/Domain-specific toolkits
    ├── business/       # [analyst agents, business rules, skills, contexts]
    ├── architecture/   # [architect agents, arch rules, skills, checklists]
    ├── api/            # [api designer agents, rest rules, skills, checklists]
    ├── database/       # [db dev agents, sql rules, skills, contexts]
    ├── backend/        # [backend dev agents, .net rules, skills, checklists]
    ├── flutter/        # [flutter dev agents, widget rules, skills, checklists]
    ├── testing/        # [qa agents, testing rules, skills, checklists]
    └── devops/         # [sre/devops agents, cloud rules, skills, checklists]
```

---

### 4.2 Core Entity Schemas

#### A. Capability Schema (`ai/domains/<domain>/capabilities/*.md`)
Defines *What* can be done. Capabilities own Skills and can be shared across multiple Agents.
```yaml
---
id: CAP-API-001
name: Design REST API
domain: api
owner: API Architect
skills: [SKL-API-001, SKL-API-002, SKL-API-003]
standards: [ai/standards/rest_standard.md]
---
```

#### B. Skill Schema (`ai/domains/<domain>/skills/*.md`)
Defines *How* to execute a Capability with local-LLM compatible step-by-step precision.
```yaml
---
id: SKL-API-001
name: REST Naming Skill
capability: CAP-API-001
version: 1.0.0
owner: API Domain Lead
dependencies: [ONT-BUS-001]
required_context: [ai/domains/api/contexts/api_context.md]
rules: [RULE-API-001]
standards: [ai/standards/rest_standard.md]
---
## Overview
## Inputs & Outputs
## Execution Steps
## Checklists & Evaluation Metrics
## Examples & Anti-Patterns
## Referenced ADRs & Related Skills
```

#### C. Machine-Readable Rule Schema (`ai/domains/<domain>/rules/*.md`)
Strict YAML frontmatter enabling automated verification during CI/CD or AI evaluation turns.
```yaml
---
id: RULE-API-001
title: Plural Nouns for Resource URIs
severity: Critical
category: REST
required_before: Business Rule Design
required_after: API Specification Draft
violation_condition: "URI path contains singular resource nouns (e.g., /user/{id} instead of /users/{id})"
---
## Explanation & Fix Guide
```

#### D. Agent Persona Schema (`ai/domains/<domain>/agents/*.md`)
Agents act as **Orchestrators** rather than containing raw skill logic.
Structure (13 Sections):
1. `Identity`
2. `Capabilities`
3. `Skill Set`
4. `Knowledge`
5. `Responsibilities`
6. `Constraints`
7. `Workflows`
8. `Checklists`
9. `Evaluation`
10. `Examples`
11. `Prompt Orchestration`
12. `Memory`
13. `References`

#### E. Prompt Schema (`ai/domains/<domain>/prompts/*.md`)
Pure orchestration wrapper with zero embedded logic.
```text
[Load Constitution] -> [Load Registry] -> [Load Context Package] -> [Inject Skill & Rules] -> [Execute Playbook/Workflow] -> [Run Evaluation Checklist]
```

---

## 5. Implementation Roadmap (4 Phases)

### Phase 0 – Foundation (Top Priority)
Establish the immutable "Constitution" of the AI platform before writing any agent or prompt.
*   [ ] `ai/constitution/core_constitution.md`
*   [ ] `ai/ontology/*.md` (business, architecture, engineering, documentation, testing, devops, ai)
*   [ ] `ai/capabilities/master_capability_matrix.md`
*   [ ] `ai/standards/*.md` (Documentation, Markdown, REST, Flutter, DDD, Git, Folder, Naming)
*   [ ] `ai/governance/*.md` (CODEOWNERS, Review Process, Lifecycle)
*   [ ] `ai/knowledge_graph/master_graph.md`

### Phase 1 – AI Core
Populate domain baskets and registries with foundational rules and skills.
*   [ ] Migrate `aios/rules` & `aios/skills` -> `ai/domains/<domain>/rules` & `skills`
*   [ ] Build Hybrid Master Indices (`ai/registry/*.md`)
*   [ ] Create Template Library (`ai/templates/*.md`)
*   [ ] Create Checklist Library (`ai/checklists/*.md`)
*   [ ] Define Context Packages (`ai/domains/<domain>/contexts/*.md`)

### Phase 2 – AI Runtime
Build multi-agent workflows, playbooks, and self-evaluation loops.
*   [ ] DAG Workflows (`ai/workflows/*.md`)
*   [ ] Standard Playbooks (`ai/playbooks/*.md`)
*   [ ] Agent Personas (`ai/domains/<domain>/agents/*.md`)
*   [ ] Evaluation Frameworks (`ai/evaluation/*.md`)

### Phase 3 – Project Knowledge & Phase 4 – Source Code
Apply the AI Engineering Platform to build and maintain the actual FSP project documentation (`docs/`) and application code (`src/`).
