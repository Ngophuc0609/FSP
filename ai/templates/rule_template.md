---
rule_id: RULE-TEMPLATE-001
title: [Rule Title]
severity: [BLOCKING | CRITICAL | HIGH | MAJOR | MINOR]
category: [Architecture | Security | API | Flutter | Testing | DevOps]
domain: [architecture | backend | flutter | api | database | testing | devops]
owner: [Role of Owner]
applies_to: [Target Languages or Layers]
required_before: [Scaffolding | Pull Request | Build]
standard_ref: [STD-xxx-001]
---

# [Rule Title]

## 1. Description
Clear explanation of what this constraint enforces and why it matters.

## 2. Mandatory Constraints
*   Constraint 1...
*   Constraint 2...

## 3. Machine-Readable Trigger Schema
```yaml
violation_trigger:
  layer: [Target Layer]
  condition: [Specific condition or forbidden pattern]
```

## 4. Examples
**Good**:
```csharp
// Compliant code example
```

**Anti-pattern**:
```csharp
// Violation code example
```
