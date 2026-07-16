---
title: Architectural & Sequence Diagram Conventions (Mermaid)
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# DIAGRAM CONVENTIONS (`Mermaid.js`)

## 1. Why Mermaid?
`FSP` mandates **Mermaid.js** (`fenced code blocks with language mermaid`) as the exclusive diagramming standard. Binary image files (`PNG`, `JPG`, `Draw.io`) are strictly prohibited in `docs/` because they cannot be version-controlled, diffed in Git pull requests, or parsed by AI agents.

## 2. Diagram Safety Rules
To prevent syntax rendering breaks in markdown viewers:
- **Quote Node Labels:** Always wrap labels containing special characters, parentheses, or brackets in double quotes: `id["Work Order (Active State)"]`.
- **Avoid HTML Tags:** Never embed raw `<br>` or `<div>` inside simple sequence diagram messages; use explicit newline syntax where supported.
