---
title: Markdown Formatting Conventions & Standards
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# MARKDOWN FORMATTING CONVENTIONS

## 1. Standard YAML Frontmatter
Every markdown file across `docs/` and `ai/` MUST begin with standardized YAML frontmatter containing title, category/version, and `last_updated` date.

## 2. Clickable File Links & Symbol Referencing
Whenever referencing a source code file or class inside documentation, AI agents and engineers MUST use standard GitHub-style links (`[filename](file:///path/to/file)`) or symbol anchors (`[WorkOrder](file:///D:/Workspace/work/FSP/src/backend/FSP.Domain/Entities/WorkOrder.cs#L10-L40)`).

## 3. Code Block Language Tagging
All fenced code blocks must explicitly specify the syntax highlighting language (`csharp`, `dart`, `sql`, `yaml`, `json`, `mermaid`, `bash`). Fenced blocks without language tags are rejected by documentation linters.
