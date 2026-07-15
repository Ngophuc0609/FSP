# Decision Log: Architecture Rules & Skills Bootstrap

**Date**: 2026-07-15
**Context**: Defining the foundational architecture rules and skills for the Field Service Platform (FSP) AI Operating System (AIOS).
**Target Deployment**: Multi-tenant SaaS (Cloud-native).

## Decision 1: Core Architectural Paradigms
*   **What was decided**: Adopt Clean Architecture, Domain-Driven Design (DDD), and CQRS as the foundational pillars for the FSP backend.
*   **Alternatives considered**: 
    *   Monolithic Layered Architecture (rejected: doesn't scale well for complex multi-tenant enterprise systems).
    *   Microservices without DDD (rejected: leads to distributed monoliths).
*   **Why this option was chosen**: FSP is a complex, multi-industry platform. Clean Architecture ensures UI/DB independence, DDD tackles domain complexity, and CQRS enables independent scaling of read and write workloads.

## Decision 2: Multi-Tenancy Strategy
*   **What was decided**: Enforce data isolation at the ORM level using Global Query Filters based on a `TenantId` extracted securely from JWT claims.
*   **Alternatives considered**:
    *   Database-per-tenant (rejected: too expensive and complex for early-stage SaaS unless required by specific enterprise clients).
    *   Schema-per-tenant (rejected: high migration complexity).
*   **Why this option was chosen**: Shared Database, Shared Schema with TenantId filtering offers the best balance of cost-efficiency and performance for a cloud-native SaaS, provided strict rules (`multi_tenant_rules.md`) are followed by all AI and human agents.

## Decision 3: AI Skill Segregation
*   **What was decided**: Separate the "Design Backend Module" (Core Skill) from "Architecture Review" (Review Skill).
*   **Alternatives considered**: Merge them into a single "Backend Architect" skill.
*   **Why this option was chosen**: Enforces the single responsibility principle. One AI instance acts as the creator (Drafting the module), and another independent instance acts as the reviewer (Auditing against the Rules). This prevents confirmation bias in AI outputs.
