---
standard_id: STD-DDD-001
title: Domain-Driven Design (DDD) & Clean Architecture Standard
version: 1.0.0
owner: Chief Enterprise Architect
scope: All backend application architecture and domain boundaries
rules_referencing: [RULE-DDD-001, RULE-DDD-002, RULE-ARCH-001]
---

# Domain-Driven Design & Clean Architecture Standard

## 1. Purpose & Scope
Defines the architectural separation of layers and DDD building blocks for `.NET` backend services.

## 2. Layer Rules
- **Domain Layer:** Pure business logic. Zero dependencies on `Microsoft.EntityFrameworkCore`, `ASP.NET Core`, or external libraries.
- **Application Layer:** Orchestrates CQRS via MediatR. Contains `IRequestHandler`, `DTOs`, `Validators (FluentValidation)`, and `Interfaces`.
- **Infrastructure Layer:** Implements `DbContext`, `Repositories`, `EmailService`, `AzureKeyVaultClient`.
- **Presentation Layer:** Controllers or Minimal API endpoints that map HTTP calls to MediatR queries/commands.

## 3. Aggregate Root Invariants
- External code MUST NOT directly modify child entities inside an `Aggregate Root`.
- All state mutations must pass through public domain methods on the `Aggregate Root`, which validate domain invariants and raise `DomainEvents`.
