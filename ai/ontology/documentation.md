---
ontology_id: ONT-DOC-001
category: Documentation Domain Vocabulary
status: Active
version: 1.0.0
owner: Technical Documentation Lead
last_updated: 2026-07-15
terms:
  - id: TRM-DOC-001
    term: Architecture Decision Record (ADR)
    definition: "A structured, immutable markdown document capturing an important architectural decision, its context, alternatives considered, and consequences."
    attributes: [adr_number, title, status, date, deciders, context, decision, consequences]

  - id: TRM-DOC-002
    term: Product Requirement Document (PRD)
    definition: "A comprehensive specification outlining the purpose, target users, features, user flows, and success criteria for a specific product capability."
    attributes: [feature_name, problem_statement, target_personas, user_stories, acceptance_criteria, non_goals]

  - id: TRM-DOC-003
    term: Business Requirement Document (BRD)
    definition: "A high-level document focusing on business needs, ROI, operational policies, and regulatory constraints before technical design occurs."
    attributes: [business_objective, stakeholder_impact, operational_rules, kpis]

  - id: TRM-DOC-004
    term: Functional Specification Document (FSD)
    definition: "A detailed engineering blueprint translating business requirements into exact technical behaviors, data schemas, API contracts, and edge cases."
    attributes: [system_context, data_dictionary, api_specifications, error_handling, performance_sla]

  - id: TRM-DOC-005
    term: Retrospective & Lesson Log
    definition: "A structured memory record capturing post-mortem analysis, root causes of incidents, discovered anti-patterns, and preventive action items."
    attributes: [incident_id, root_cause, anti_pattern_identified, preventive_rule_created]
---

# Documentation Ontology & Artifact Standards

## Overview
This file defines the exact vocabulary and structural purpose of documentation artifacts inside the FSP repository. AI agents writing or reviewing docs (`tech_writer`, `ai_reviewer`, `business_analyst`) must ensure that documents match these exact terms and schemas.

## Document Lifecycle & Statusing

All documentation artifacts (PRDs, BRDs, ADRs, FSDs) MUST include a YAML frontmatter `status` field with one of the following canonical values:
- **Draft:** Work in progress, under active AI or human authoring.
- **UnderReview:** Submitted for peer review or architect verification.
- **Approved:** Fully validated and locked for implementation.
- **Deprecated:** Superseded by a newer architectural decision or retired feature.
- **Rejected:** Evaluated and declined during brainstorming or review.

## ADR Numbering & Structure Standard
- File naming format: `ADR-NNN-short-kebab-title.md` (e.g., `ADR-001-adopt-grpc-for-telemetry.md`).
- Must strictly contain: Status, Context, Decision, Alternatives Considered, and Positive/Negative Consequences.
