---
id: generate_flutter_feature
title: Prompt Wrapper - Generate Flutter Mobile Feature
tier: 4_prompt_wrappers
domain: flutter
target_agent: ai/domains/flutter/agents/flutter_dev.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: GENERATE FLUTTER MOBILE FEATURE

This prompt wrapper coordinates the execution of the Principal Flutter Mobile Developer persona to build high-performance, offline-first mobile features using `Riverpod 2.x`, `Freezed`, `GoRouter`, `Dio`, and `Drift`.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA
Read and internalize:
- `ai/shared/project_charter.md`
- `ai/shared/project_objective.md`
- `ai/shared/universal_rules.md`
- `ai/shared/design_principles.md`
- `ai/shared/glossary.md`

### Step 2: Load Domain Micro-Context
Read and internalize:
- `ai/contexts/flutter_context.md`

### Step 3: Load Relevant Standards
Read and internalize:
- `ai/standards/flutter_standard.md`
- `ai/standards/naming_standard.md`

### Step 4: Load Domain Rules & Knowledge Graph
Check:
- `ai/knowledge_graph/master_graph.md` (verify API endpoint readiness and mobile screen linkages)
- `ai/domains/flutter/rules/`

### Step 5: Execute Target Agent Persona
Activate `ai/domains/flutter/agents/flutter_dev.md`. Pass the user's specific feature request and instruct the agent to scaffold:
1. Feature directory structure (`features/<name>/domain/`, `data/`, `presentation/`).
2. Immutable domain models using `Freezed` (`@freezed`).
3. Repository interfaces and implementations (`Dio` remote + `Drift` local offline table).
4. Riverpod `AsyncNotifierProvider` or `StateNotifierProvider` managing UI state.
5. Touch-ergonomic `ConsumerWidget` with clear loading, error, and offline sync indicators.

### Step 6: Review & Audit Result
Execute `ai/domains/architecture/agents/ai_reviewer.md` to verify no raw HTTP calls reside inside UI widgets, `snake_case.dart` filenames, and offline sync queue adherence.

### Step 7: Output Final Artifact
Emit the verified code using the mandatory 7-section layout defined in `ai/shared/output_format.md` (`Objective`, `Assumptions`, `Design Decisions`, `Implementation`, `Risks`, `Validation Checklist`, `Next Recommended Step`).
