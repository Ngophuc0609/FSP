---
version: 1.0
owner: Architecture Team
level: Review Skills
tags: [architecture, review, pr]
---
# Skill: Architecture Review

## 1. Purpose
To evaluate code, PRs, or System Designs against the FSP Architectural Rules.

## 2. Applicable Roles
*   AI Reviewer
*   Software Architect
*   Solution Architect

## 3. Required Context & Rules
*   `clean_architecture_rules.md`
*   `ddd_rules.md`
*   `cqrs_rules.md`
*   `multi_tenant_rules.md`

## 4. Execution Steps
1.  **Analyze**: Read the input code/design.
2.  **Verify Clean Architecture**: Ensure dependencies point inward. Ensure Domain has no external references.
3.  **Verify CQRS**: Ensure commands don't return complex DTOs and Queries don't mutate state.
4.  **Verify Multi-tenancy**: Check for `TenantId` handling in repositories or queries.
5.  **Output**: Generate a Markdown report listing Violations, Warnings, and Approvals.

## 5. Prompt Skeleton
```text
System: You are a Software Architect executing the [Architecture Review] skill.
Context: Apply rules from [R-ARCH-CLEAN-001, R-ARCH-DDD-001, R-ARCH-CQRS-001, R-SEC-MT-001].
Input: {PR_DIFF_OR_CODE}
Task: Review the input and produce a strict architectural audit report. Cite the specific rule ID if a violation is found.
```
