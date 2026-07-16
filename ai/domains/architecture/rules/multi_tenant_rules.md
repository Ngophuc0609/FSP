---
rule_id: RULE-SEC-MT-001
title: Multi-Tenant TenantId Isolation Rule
severity: BLOCKING
category: Security & Database
domain: architecture
owner: Security & Cloud Architect
applies_to: [Database, .NET Backend, API]
required_before: [Database Migration, Repository Execution]
standard_ref: STD-REST-001
---

# Multi-Tenant Isolation Rules

## 1. Description
As a cloud-native SaaS, FSP serves multiple corporate customers (tenants). Data leakage between tenants is a **BLOCKING** severity security vulnerability.

## 2. Mandatory Rules
*   **Database Level**: Every table containing tenant-specific operational data (`work_orders`, `assets`, `technicians`) MUST include a `tenant_id` column indexed with foreign keys where applicable.
*   **Global Query Filtering**: Global Query Filters MUST be configured in EF Core `OnModelCreating` to automatically append `WHERE tenant_id = @CurrentTenant` to every query. Never rely on developers manually appending `.Where(x => x.TenantId == tenantId)`.
*   **Command Verification**: All update and delete operations must verify that the target entity's `TenantId` matches the current request's scoped `ITenantContext`.
*   **Secure Extraction**: `TenantId` MUST ONLY be extracted from trusted JWT claims (`http://schemas.microsoft.com/identity/claims/tenantid`). NEVER accept `TenantId` from URL paths, query parameters, or request body payloads for authorization decisions.
