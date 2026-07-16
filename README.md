# FSP (Field Service Platform) & AI Engineering Platform v2.0.0

Welcome to the **Field Service Platform (FSP)** repository. This repository implements an enterprise-grade mobile and cloud platform designed for field technicians, asset maintenance tracking, inspection execution, and real-time dispatching.

More importantly, FSP is built upon a state-of-the-art **AI Engineering Platform (AI Operating System v2.0.0)** designed to empower humans and autonomous AI agents (`Claude`, `Cursor`, `Copilot`, `Gemini`, and `Local LLMs`) to co-develop, audit, and maintain software with zero architectural erosion.

---

## 🛑 MANDATORY BOOTSTRAPPING FOR ALL AI ASSISTANTS

If you are an AI assistant or coding agent starting a new session in this repository, **YOU MUST EXECUTE THE FOLLOWING BOOTSTRAP PROTOCOL BEFORE WRITING OR MODIFYING ANY CODE:**

1. **Read the AI Constitution:**  
   Review the supreme laws governing this codebase at **[`ai/constitution/core_constitution.md`](file:///D:/Workspace/work/FSP/ai/constitution/core_constitution.md)**.
2. **Review the Repository Map:**  
   Understand the physical folder boundaries and structure at **[`REPO_MAP.md`](file:///D:/Workspace/work/FSP/REPO_MAP.md)**.
3. **Verify Domain Vocabulary:**  
   Never guess or hallucinate business entities. Lookup canonical definitions in **[`ai/ontology/`](file:///D:/Workspace/work/FSP/ai/ontology/business.md)** (`business.md`, `architecture.md`, `engineering.md`).
4. **Consult Hybrid Registries:**  
   Before executing a complex engineering task, check **[`ai/registry/`](file:///D:/Workspace/work/FSP/ai/registry/skill_registry.md)** for pre-built `Skills`, `Rules`, `Standards`, and `Agent Personas` (`agent_registry.md`, `skill_registry.md`).
5. **Trace Downstream Impact:**  
   Before modifying any database table, API endpoint, or domain model, check **[`ai/knowledge_graph/master_graph.md`](file:///D:/Workspace/work/FSP/ai/knowledge_graph/master_graph.md)** to verify dependencies across the entire relationship chain (`Feature -> Rule -> API -> DB -> Screen -> Permission -> Notification -> Sync -> Test`).

---

## 🗂️ High-Level Directory Overview

```text
D:\Workspace\work\FSP\
├── ai/                      # AI Engineering Platform v2.0.0 (The AI Operating System)
│   ├── constitution/        # Supreme operating laws and principles
│   ├── ontology/            # Canonical domain dictionaries (Business, Arch, Eng, DevOps)
│   ├── capabilities/        # High-level capability matrix (What can be done)
│   ├── standards/           # Baseline technical specifications (REST, Flutter, DDD, Git)
│   ├── governance/          # CODEOWNERS, multi-tier review process, lifecycle policies
│   ├── registry/            # Hybrid master indices (~500 tokens) for fast AI lookup
│   ├── knowledge_graph/     # Impact analysis matrices and relational Mermaid diagrams
│   ├── domains/             # Domain-bounded baskets (architecture, backend, flutter, api...)
│   ├── playbooks/           # SOP execution instructions and checklists
│   ├── workflows/           # Multi-agent DAG orchestration flows
│   ├── evaluation/          # Automated linter scripts, gates, and validation benchmarks
│   ├── memory/              # ADRs, Retrospectives, Lesson Logs, and discovered anti-patterns
│   └── templates/           # Scaffolding templates for new rules, skills, and code modules
├── docs/                    # Human & AI co-authored project documentation (PRDs, BRDs, FSDs)
├── src/                     # Application source code
│   ├── backend/             # .NET Core 8+ Backend Services (MediatR, Clean Arch, EF Core)
│   ├── flutter/             # Flutter Mobile Applications (BLoC, Isar/SQLite offline-first)
│   └── web/                 # Web Management Portals & Admin Dashboard
├── REPO_MAP.md              # Detailed physical layout & navigation guide
└── README.md                # This entry point
```

---

## 🚀 Quick Start for Human Developers

### 1. Prerequisites
- **Backend:** .NET SDK 8.0+, SQL Server 2022 / Docker
- **Mobile:** Flutter SDK 3.22+, Dart 3.4+, Android Studio / Xcode
- **AI Tools:** `ripgrep`, `ast-grep`, `Node.js` (for AI evaluation scripts)

### 2. Running the Backend Locally
```bash
cd src/backend
dotnet restore
dotnet build
dotnet run --project FSP.Api
```

### 3. Running the Flutter App Locally
```bash
cd src/flutter
flutter pub get
flutter run
```

---

## 🏛️ Governance & Contributing
- All changes must pass the two-tier verification gate outlined in **[`ai/governance/review_process.md`](file:///D:/Workspace/work/FSP/ai/governance/review_process.md)**.
- For complete architectural background and design decisions, read **[`ai/AI_ENGINEERING_PLATFORM_DESIGN.md`](file:///D:/Workspace/work/FSP/ai/AI_ENGINEERING_PLATFORM_DESIGN.md)**.
