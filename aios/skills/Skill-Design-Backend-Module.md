---
version: 1.0
owner: Backend Team
level: Core Engineering Skills
tags: [backend, csharp, dotnet, design]
---
# Skill: Design Backend Module

## 1. Purpose
To design the structural skeleton of a new backend module/feature following Clean Architecture and DDD principles.

## 2. Applicable Roles
*   Backend Architect
*   Backend Developer

## 3. Required Context & Rules
*   `clean_architecture_rules.md`
*   `ddd_rules.md`
*   `cqrs_rules.md`

## 4. Execution Steps
1.  **Identify Aggregates**: Based on the PRD, define the Aggregate Roots and Value Objects.
2.  **Define Commands**: List all operations that mutate state.
3.  **Define Queries**: List all read models required by the UI.
4.  **Scaffold Structure**: Output the exact folder and file structure for the module (Domain, Application, Infrastructure, Presentation).
5.  **Draft Interfaces**: Write the initial C# interfaces for Repositories and MediatR Handlers.

## 5. Anti-patterns
*   Designing anemic domain models (entities with only getters/setters and no logic).
*   Creating a single monolithic repository for all entities instead of per Aggregate Root.
