---
skill_id: SKL-ARCH-001
title: Architecture Review & Audit Skill
version: 1.0.0
owner: Chief Enterprise Architect
domain: architecture
capability: CAP-ARCH-REVIEW
inputs: [PR Diff, System Design Document, C4 Diagram]
outputs: [Structured Markdown Architecture Audit Report]
rules_referencing: [RULE-ARCH-CLEAN-001, RULE-ARCH-CQRS-001, RULE-DDD-001, RULE-SEC-MT-001]
---

# Skill: Architecture Review

## 1. Purpose
To systematically audit code pull requests, database schemas, or system designs against FSP constitutional laws and architectural rules.

## 2. Applicable Roles (`ai_reviewer`, `chief_architect`)
When executing this skill, the AI must adopt the strict persona of the `Chief Enterprise Architect`.

## 3. Execution Steps
1.  **Analyze Input:** Read the target diff or design specification thoroughly.
2.  **Check Clean Architecture (`RULE-ARCH-CLEAN-001`):** Verify that inner domain layers do not reference outer infrastructure or framework dependencies (`Microsoft.EntityFrameworkCore`, `ASP.NET`).
3.  **Check CQRS Boundaries (`RULE-ARCH-CQRS-001`):** Verify that commands return IDs/Results without complex joins, and queries do not execute state mutations.
4.  **Check Multi-Tenancy (`RULE-SEC-MT-001`):** Verify that any new database table has a `TenantId` column and global query filters registered.
5.  **Check Impact Graph (`KGRAPH-MASTER-001`):** Trace dependencies to see if the change breaks mobile offline sync queues or existing permissions.
6.  **Generate Report:** Output a markdown audit report categorizing findings into **[BLOCKING VIOLATION]**, **[WARNING]**, or **[APPROVED]**. Cite the exact Rule ID for each finding.
