---
title: Business Analysis & Requirements Engineering Rules
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# BUSINESS ANALYSIS RULES (`RULE-BA-001` to `003`)

## RULE-BA-001: Ubiquitous Language Compliance
All requirements specifications (PRD, BRD, FSD) must use exact canonical domain dictionary terms (`WorkOrder`, `Technician`, `Assignment`, `Inspection`, `Asset`, `TenantId`) and avoid synonyms (`Job`, `Ticket`).

## RULE-BA-002: Mandatory Acceptance Criteria & SLAs
Every business requirement (`BR-*`) must specify measurable acceptance criteria and operational SLAs (e.g., First-Time Fix Rate `>= 88%`, SLA breach notification `< 60 seconds`).
