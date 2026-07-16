---
standard_id: STD-DOC-001
title: Documentation Standard
version: 1.0.0
owner: Technical Documentation Lead
scope: All documentation artifacts (PRD, BRD, FSD, ADR, Release Notes) across FSP
rules_referencing: [RULE-DOC-001, RULE-DOC-002]
---

# Documentation Standard

## 1. Purpose & Scope
This document establishes the mandatory structural rules and quality criteria for all technical and business documentation across FSP.

## 2. Mandatory YAML Frontmatter
Every documentation artifact MUST begin with structured YAML frontmatter containing:
- `document_id`: Unique identifier (e.g., `PRD-BUS-001`, `ADR-004`)
- `title`: Human-readable title
- `status`: One of `[Draft, UnderReview, Approved, Deprecated, Rejected]`
- `owner`: Responsible role or domain team
- `created_date` & `last_updated`

## 3. Writing Style & Tone
- Be direct, professional, and unambiguous.
- Use active voice and concrete statements ("The system must validate..." instead of "It would be good if validation happens...").
- When writing specifications for AI consumption, use clear bullet lists, tables, and Mermaid diagrams over dense narrative paragraphs.
