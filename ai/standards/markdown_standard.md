---
standard_id: STD-MD-001
title: Markdown & Formatting Standard
version: 1.0.0
owner: Chief Enterprise Architect
scope: All .md files across docs/ and ai/ directories
rules_referencing: [RULE-MD-001]
---

# Markdown & Formatting Standard

## 1. Purpose & Scope
To ensure maximum compatibility with Git diffs, human readability, and AI parser indexing (`ripgrep`, `ast-grep`, Local LLMs).

## 2. Structural Conventions
- **Headers:** Always use ATX headers (`# Header 1`, `## Header 2`). Never underline with `===` or `---`.
- **Line Length:** Keep sentences concise. Avoid horizontal scrolling where possible.
- **Code Blocks:** Every fenced code block MUST explicitly specify the language syntax (`python`, `csharp`, `dart`, `yaml`, `json`, `sql`, `mermaid`). Never use raw ```` ``` ```` without a language identifier.
- **Tables:** Use standard GitHub Flavored Markdown (GFM) tables for structured multi-dimensional comparisons.
- **File Links:** When referencing files in Markdown, always use clear relative or project-absolute links.
