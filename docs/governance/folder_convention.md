---
title: Folder Structure Conventions & Layout Standard
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# FOLDER STRUCTURE CONVENTIONS

## 1. Directory Tree Organization
- **`src/backend/`:** Multi-project .NET 8 solution (`FSP.sln`) organized cleanly by architectural layers (`FSP.Domain/`, `FSP.Application/`, `FSP.Infrastructure/`, `FSP.Api/`).
- **`src/flutter/`:** Feature-first Flutter mobile architecture (`lib/features/<feature_name>/domain/`, `data/`, `presentation/`).
- **`ai/`:** 5-Tier AI Engineering Platform v2.0.0 (`constitution/`, `shared/`, `contexts/`, `domains/`, `prompts/`, `workflows/`).
- **`docs/`:** Categorized human and AI co-authored project documentation (`product/`, `business/`, `architecture/`, `api/`, `database/`, `testing/`, `devops/`, `governance/`, `knowledge/`).

---

## 2. Directory Naming Rule
All directories must use `snake_case` or standard lowercase (except exact C# solution/project folders which use `PascalCase` like `FSP.Domain`).
