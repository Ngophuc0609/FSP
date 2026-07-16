---
standard_id: STD-DIR-001
title: Folder & Directory Structure Standard
version: 1.0.0
owner: Chief Enterprise Architect
scope: The entire physical structure of the FSP repository
rules_referencing: [RULE-DIR-001]
---

# Folder & Directory Structure Standard

## 1. Single Source of Truth
- `ai/`: Top-level directory containing all 16 modules of the AI Engineering Platform (`constitution`, `ontology`, `standards`, `governance`, `registry`, `knowledge_graph`, `domains`, etc.).
- `docs/`: Human and AI co-authored project documentation (`business/`, `architecture/`, `api/`, `database/`, `testing/`, `devops/`).
- `src/`: Application source code (`src/backend/`, `src/flutter/`, `src/web/`).

## 2. Naming Conventions for Directories
- All directory names MUST be strictly lowercase, separated by underscores (`snake_case`) or hyphens (`kebab-case`). No spaces or uppercase characters in folder paths.
