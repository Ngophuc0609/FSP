---
id: project_objective
title: Field Service Platform - Universal Project Objective
tier: 1_project_dna
layer: universal_shared
version: 2.0.0
last_updated: 2026-07-15
---

# UNIVERSAL PROJECT OBJECTIVE

## 1. The Single Unified Objective
Every task performed by every AI agent across this repository must contribute directly toward one supreme objective:

> **To continuously evolve the Field Service Platform (FSP) into a robust, secure, highly performant, and production-grade enterprise SaaS platform.**

The objective is **NOT** merely generating code to satisfy a local prompt.  
The objective is **NOT** creating isolated snippets that pass superficial checks while degrading system integrity.

---

## 2. Holistic Quality Enhancement
Every artifact generated or modified by an AI agent must measurably increase the system's score across six core pillars:

1. **Architectural Consistency:** Strictly respecting layer boundaries, bounded contexts, and domain invariants.
2. **Long-term Maintainability:** Ensuring code is self-documenting, modular, readable, and easy for human engineers to modify five years from now.
3. **Horizontal Scalability:** Ensuring data queries, background jobs, and API endpoints perform efficiently from 100 to 100,000 active concurrent technicians.
4. **Enterprise Security:** Enforcing tenant isolation, zero-trust authorization, input sanitization, and audit logging across all operations.
5. **Direct Business Value:** Solving real-world field service operational pain points (SLA breaches, dispatch delays, inventory shrinkage, offline data loss).
6. **Documentation & Knowledge Quality:** Keeping Architectural Decision Records (ADRs), API OpenAPI specs, and domain dictionaries perfectly synchronized with executable code.

---

## 3. Decision Resolution Hierarchy
When an AI agent faces multiple technical approaches or design alternatives during implementation, it **MUST resolve tradeoffs using the following prioritized hierarchy**:

### Tier 1: Clean Architecture & Domain-Driven Design (Highest Priority)
If an approach violates Domain isolation or leaks data access concerns into application/presentation layers, **it must be rejected immediately**, even if it is faster or requires fewer lines of code.

### Tier 2: Low Coupling & High Cohesion
Prefer modular boundaries where internal components change together for the same business reason (High Cohesion) and interact with neighboring modules only through well-defined interfaces or domain events (Low Coupling).

### Tier 3: Long-term Longevity & Reliability over Short-term Speed
Never optimize for immediate execution speed or developer convenience if it introduces technical debt, concurrency hazards, or fragility. **Always optimize for project longevity.**

### Tier 4: Explicit over Implicit
Prefer explicit data contracts, explicit mapping definitions, and explicit error handling (`Result<T>` / `Either` / `ProblemDetails`) over hidden reflection, magic conventions, or silent try-catch swallowing.
