---
rule_id: RULE-API-REST-001
title: REST API Naming & Status Code Rule
severity: HIGH
category: API Design
domain: api
owner: API Domain Lead
applies_to: [.NET Backend API Controllers, Minimal APIs]
required_before: [Endpoint Scaffolding, OpenAPI Generation]
standard_ref: STD-REST-001
---

# REST API Guidelines & Naming Rules

## 1. Description
Ensures APIs are intuitive, standard-compliant, and predictable across all FSP client endpoints.

## 2. Mandatory Rules
*   **Nouns, Not Verbs**: URIs must represent resources (plural nouns), not actions.
    *   *Correct*: `POST /api/v1/work-orders`
    *   *Incorrect*: `POST /api/v1/createWorkOrder`
*   **Pluralization**: Resource paths must be pluralized (`/api/v1/users`, `/api/v1/inspections`).
*   **HTTP Status Codes**:
    *   `200 OK`: Successful retrieval or update returning payload.
    *   `201 Created`: Successful creation (must return `Location` header).
    *   `204 No Content`: Successful command execution without payload.
    *   `400 Bad Request`: Validation failure (`ProblemDetails`).
    *   `401 Unauthorized`: Missing or invalid JWT.
    *   `403 Forbidden`: Insufficient RBAC permission.
    *   `404 Not Found`: Resource ID not found.
    *   `409 Conflict`: Business or concurrency violation.
*   **Mandatory Versioning**: Every API route must explicitly declare versioning (`/api/v1/...`).
