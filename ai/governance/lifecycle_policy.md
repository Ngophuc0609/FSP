---
policy_id: GOV-LIFE-001
title: Artifact & Entity Lifecycle Policy
version: 1.0.0
owner: Chief Enterprise Architect
last_updated: 2026-07-15
---

# Artifact & Entity Lifecycle Policy

## 1. Purpose & Scope
Governs the creation, active usage, deprecation, and archiving of all AI Engineering Platform entities (`Skills`, `Rules`, `Prompts`, `ADRs`, `Ontology Terms`).

## 2. Status States
All YAML frontmatter artifacts must maintain a valid lifecycle `status`:
- `Draft`: Initial authoring phase. Excluded from production registries and linters.
- `UnderReview`: Submitted for review.
- `Active` / `Approved`: Fully validated, registered in `ai/registry/`, and enforced by workflows.
- `Deprecated`: Superseded by a newer artifact. Must include `superseded_by: <new_id>` in frontmatter.
- `Archived`: Retired from active evaluation but preserved for historical audit and retrospective context.

## 3. Deprecation Procedure
When a skill, rule, or ontology term is deprecated:
1. Update its frontmatter `status` to `Deprecated` and set `superseded_by`.
2. Update the master index in `ai/registry/` to mark it as `Deprecated`.
3. Log an entry in `ai/memory/lessons/` noting why the entity was replaced to prevent future regression.
