---
policy_id: GOV-OWN-001
title: CODEOWNERS & Human-AI Governance Policy
version: 1.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
---

# CODEOWNERS & Human-AI Governance Policy

## 1. Governance Supremacy
The Field Service Platform (FSP) repository enforces strict governance over AI-generated modifications. While AI agents are empowered to scaffold code, write tests, draft documentation, and log lessons learned, human enterprise architects and domain leads maintain sole oversight over constitutional and structural boundaries.

## 2. Directory Ownership Matrix

| Directory Pattern | Designated Owner | AI Authorization Level | Mandatory Reviewer |
| :--- | :--- | :--- | :--- |
| `ai/constitution/` | Chief Enterprise Architect | **Read-Only** (No AI commits without human PR approval) | Chief Enterprise Architect |
| `ai/ontology/` | Domain Leads | **Read / Draft** (AI can propose terms via PR) | Business / Tech Leads |
| `ai/standards/` | Principal Engineers | **Read / Draft** (AI can propose refinements) | Chief Enterprise Architect |
| `ai/governance/` | Chief Enterprise Architect | **Read-Only** | Chief Enterprise Architect |
| `ai/registry/` | AI System / Architects | **Read / Propose** (AI updates indices on artifact creation) | Automated Linter / Tech Lead |
| `ai/knowledge_graph/`| AI System / Architects | **Read / Propose** (AI updates impact matrices via PR) | Automated Linter / Tech Lead |
| `ai/memory/` | AI Agents / Team | **Autonomous Write via PR** (ADRs, Retrospectives) | Peer Reviewer |
| `src/backend/` | Backend Domain Team | **Autonomous Scaffolding / Code Generation via PR** | Principal Backend Engineer |
| `src/flutter/` | Mobile Domain Team | **Autonomous Scaffolding / Code Generation via PR** | Principal Mobile Engineer |

## 3. GitHub CODEOWNERS Rules Definition
The physical `.github/CODEOWNERS` file in this repository must mirror the ownership rules above.
