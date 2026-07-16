---
title: Code Ownership & CODEOWNERS Matrix - Field Service Platform (FSP)
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# CODE OWNERSHIP & CODEOWNERS MATRIX

## 1. Domain Ownership Rules
To maintain architectural boundaries and prevent unauthorized cross-layer mutations, `FSP` enforces strict CODEOWNERS rules via GitHub (`.github/CODEOWNERS`):

```bash
# Domain Core (Pure C# Invariants) - Require Chief Architect approval
/src/backend/FSP.Domain/ @enterprise-architect @chief-backend-lead

# Application Layer (CQRS Handlers) - Require Backend Lead approval
/src/backend/FSP.Application/ @chief-backend-lead

# Infrastructure & Migrations - Require Database & Backend Lead approval
/src/backend/FSP.Infrastructure/ @db-architect-lead @chief-backend-lead

# Flutter Mobile Client - Require Flutter Lead approval
/src/flutter/ @flutter-mobile-lead

# AI Engineering Platform & Governance - Require AI Platform Architect approval
/ai/ @ai-platform-architect
/docs/ @technical-writing-lead
```
