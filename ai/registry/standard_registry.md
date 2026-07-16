---
registry_id: REG-STD-001
title: Master Standard Registry
version: 1.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
token_estimate: ~300 tokens
---

# Master Standard Registry

This index lists all baseline technical and architectural standards across FSP.

| Standard ID | Title | Target File Path | Scope & Applicability |
| :--- | :--- | :--- | :--- |
| `STD-DOC-001` | **Documentation Standard** | `ai/standards/documentation_standard.md` | PRDs, BRDs, FSDs, ADRs, and YAML Frontmatter requirements |
| `STD-MD-001` | **Markdown & Formatting Standard** | `ai/standards/markdown_standard.md` | ATX headers, fenced code blocks, language syntax highlighting |
| `STD-REST-001` | **REST API Design Standard** | `ai/standards/rest_standard.md` | Plural URIs, HTTP status codes (`200`, `201`, `400`), pagination |
| `STD-FLUTTER-001`| **Flutter Mobile Standard** | `ai/standards/flutter_standard.md` | Stateless widgets, BLoC state management, Isar offline synchronization |
| `STD-DDD-001` | **Clean Architecture & DDD Standard**| `ai/standards/ddd_standard.md` | Layer independence, MediatR CQRS separation, Aggregate Roots |
| `STD-GIT-001` | **Git & Branching Standard** | `ai/standards/git_standard.md` | Trunk-based feature branches (`feature/*`), Conventional Commits |
| `STD-DIR-001` | **Folder Structure Standard** | `ai/standards/folder_standard.md` | Snake-case directory naming and top-level boundaries (`ai/`, `docs/`, `src/`) |
| `STD-NAME-001` | **Code Naming Standard** | `ai/standards/naming_standard.md` | `PascalCase`, `camelCase`, and `snake_case` rules across languages |
