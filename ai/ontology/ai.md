---
ontology_id: ONT-AI-001
category: AI Engineering Platform Vocabulary
status: Active
version: 1.0.0
owner: Chief AI Engineering Lead
last_updated: 2026-07-15
terms:
  - id: TRM-AI-001
    term: AI Constitution
    definition: "The supreme set of immutable principles and operating boundaries (`ai/constitution/`) governing all AI assistants across FSP."
    attributes: [articles, enforcement_level, priority]

  - id: TRM-AI-002
    term: Ontology
    definition: "The canonical domain dictionaries (`ai/ontology/`) defining exact business, architectural, and engineering terms to prevent AI hallucination."
    attributes: [ontology_id, terms, definitions, relationships]

  - id: TRM-AI-003
    term: Capability Matrix
    definition: "A structured functional inventory (`ai/capabilities/`) defining *What* the system or team can accomplish. Capabilities own Skills and are shared by Agents."
    attributes: [capability_id, name, domain, owned_skills, required_standards]

  - id: TRM-AI-004
    term: Skill
    definition: "A modular, reusable unit of instruction (`ai/domains/<domain>/skills/`) defining *How* an AI executes a specific capability with step-by-step guidance."
    attributes: [skill_id, name, capability, inputs, outputs, execution_steps, rules, standards]

  - id: TRM-AI-005
    term: Machine-Readable Rule
    definition: "A deterministic constraint (`ai/domains/<domain>/rules/`) structured with YAML frontmatter to allow automated linter or evaluation verification."
    attributes: [rule_id, severity, category, required_before, required_after, violation_condition]

  - id: TRM-AI-006
    term: Standard
    definition: "A foundational specification (`ai/standards/`) establishing baseline technical quality (e.g., REST Standard, Flutter Standard, Markdown Standard)."
    attributes: [standard_id, scope, rules_referencing]

  - id: TRM-AI-007
    term: Agent Persona
    definition: "An AI role orchestrator (`ai/domains/<domain>/agents/`) combining identity, capabilities, workflows, checklists, and evaluation loops."
    attributes: [agent_id, role, capabilities, responsibilities, constraints, prompt_orchestration]

  - id: TRM-AI-008
    term: Prompt Wrapper
    definition: "An orchestration template (`ai/domains/<domain>/prompts/`) containing zero embedded business logic, used to load registries, contexts, and skills."
    attributes: [prompt_id, target_workflow, injected_context, execution_sequence]

  - id: TRM-AI-009
    term: Hybrid Registry
    definition: "Compact master index files (~500 tokens in `ai/registry/`) listing all entity metadata for fast AI Dependency Injection without context window bloat."
    attributes: [registry_type, indexed_entities, token_estimate]

  - id: TRM-AI-010
    term: Knowledge Graph
    definition: "A dual-model linkage system (`ai/knowledge_graph/`) tracing cross-layer relationships from Features down to Tests for automated Impact Analysis."
    attributes: [graph_id, nodes, edges, mermaid_diagrams, impact_matrices]

  - id: TRM-AI-011
    term: Playbook & Workflow
    definition: "Standard Operating Procedures (`ai/playbooks/`) and multi-agent DAG flows (`ai/workflows/`) for executing complex engineering deliverables."
    attributes: [playbook_id, inputs, steps, required_checklists, evaluation_gate]

  - id: TRM-AI-012
    term: Evaluation & Memory Loop
    definition: "Self-review validation gates (`ai/evaluation/`) and continuous learning stores (`ai/memory/`) tracking ADRs, retrospectives, and anti-patterns."
    attributes: [eval_id, checklist_ref, memory_store, lessons_captured]
---

# AI Engineering Platform Ontology

## Overview
This file defines the foundational vocabulary of the FSP AI Operating System (AIOS). Every AI agent operating inside this repository must understand these terms to navigate the folder structure, inject dependencies correctly, and maintain architectural integrity across all 4 implementation phases.

## Core Architectural Hierarchy

```text
[ AI Constitution ] (Supreme Rules)
        ↓
   [ Ontology ] (Common Vocabulary)
        ↓
 [ Capability Matrix ] (What can be done)
        ↓
  [ Standards ] (Base Specifications)
        ↓
[ Machine-Readable Rules ] (Enforceable Constraints)
        ↓
   [ Skills ] (How to execute step-by-step)
        ↓
 [ Checklists & Templates ] (Validation & Structure)
        ↓
[ Workflows & Playbooks ] (SOP Execution Pipelines)
        ↓
[ Agents & Prompts ] (Orchestrators & Bootstrappers)
        ↓
[ Evaluation & Memory ] (Self-Audit & Continuous Learning)
        ↓
 [ Knowledge Graph ] (Impact Analysis & Relational Traceability)
```
