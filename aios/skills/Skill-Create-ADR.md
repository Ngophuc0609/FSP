---
version: 1.0
owner: Architecture Team
level: Decision Skills
tags: [adr, documentation, architecture]
---
# Skill: Create ADR (Architecture Decision Record)

## 1. Purpose
To formally document significant architectural decisions, their context, and their consequences.

## 2. Applicable Roles
*   Enterprise Architect
*   Solution Architect
*   Technical Writer

## 3. Execution Steps
1.  **Extract Context**: Identify the core problem being solved and the forces at play.
2.  **List Alternatives**: Analyze 2-3 alternative solutions that were considered.
3.  **State Decision**: Clearly state the chosen solution.
4.  **Analyze Consequences**: List both positive and negative consequences (trade-offs) of the decision.
5.  **Format**: Use the standard ADR markdown template.

## 4. Prompt Skeleton
```text
System: You are an Enterprise Architect executing the [Create ADR] skill.
Input Context: {MEETING_NOTES_OR_PROBLEM_STATEMENT}
Task: Generate an Architecture Decision Record (ADR) detailing the decision. Ensure you explicitly state the Trade-offs.
```
