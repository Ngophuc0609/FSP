# AI Constitution - Supreme Operating Principles

**Repository:** FSP (Field Service Platform)  
**Document ID:** CONST-CORE-001  
**Version:** 1.0.0  
**Effective Date:** 2026-07-15  
**Enforcement Level:** Supreme (Immutable & Mandatory across all AI Agents and Workflows)

---

## Preamble

This AI Constitution establishes the fundamental, non-negotiable laws governing every Artificial Intelligence assistant (Claude, Cursor, Copilot, ChatGPT, Gemini, or Local LLMs) operating within the Field Service Platform (FSP) repository. 

No prompt override, user instruction, or local skill logic may supersede the articles of this Constitution unless formally amended through a human-approved pull request reviewed by the Chief Enterprise Architect.

---

## Article I: Ontology First (Domain Accuracy & Vocabulary Supremacy)

1. **Mandatory Lookup:** Before generating any code, documentation, or architecture design, the AI MUST verify domain terminology against the official Ontology files in `ai/ontology/`.
2. **No Hallucinated Concepts:** The AI shall never guess, invent, or assume definitions for business entities (e.g., `Work Order`, `Task`, `Assignment`, `Inspection`, `Asset`).
3. **Consistent Naming:** All database tables, API payloads, domain entities, and UI screens MUST strictly use the exact terms defined in `ai/ontology/business.md` and related ontology dictionaries.

---

## Article II: Rule Obedience & Standard Compliance

1. **Standard Primacy:** All engineering decisions must strictly comply with the foundational standards in `ai/standards/` (e.g., `rest_standard.md`, `flutter_standard.md`, `ddd_standard.md`).
2. **Machine-Readable Rules:** Before implementing or reviewing code, the AI MUST check applicable rules in `ai/domains/<domain>/rules/` and verify that no critical or blocking violations occur.
3. **Explicit Rule Citation:** When submitting a pull request or code review, the AI MUST explicitly cite the Rule IDs and Standards adhered to during execution.

---

## Article III: Impact Traceability & Knowledge Graph Maintenance

1. **Holistic Impact Analysis:** Before proposing changes to any schema, API, or core entity, the AI MUST consult `ai/knowledge_graph/` and relevant entity frontmatter to identify downstream dependencies.
2. **Dependency Preservation:** A change in one layer (e.g., `Database Schema`) MUST be evaluated across the entire relationship chain:
   `Feature -> Business Rule -> API -> Database Table -> Flutter Screen -> Permission -> Notification -> Offline -> Sync -> Test`.
3. **Graph Synchronization:** If a new relationship is created or broken during execution, the AI MUST propose an update to the corresponding Knowledge Graph files.

---

## Article IV: Zero-Tolerance Security & Privacy (Data Shield)

1. **No Secret Storage:** The AI shall NEVER write, commit, or log hardcoded API keys, passwords, database connection strings, tokens, or private credentials into any file, including `ai/memory/` and `ai/knowledge_graph/`.
2. **No PII Persistence:** Personally Identifiable Information (PII) or sensitive customer data MUST NEVER be recorded in prompts, registries, or lesson logs.
3. **Secure By Design:** All generated code MUST follow secure coding guidelines (OWASP Top 10) and include proper input validation, authentication, and authorization checks (`Permission` layer).

---

## Article V: Local LLM Compatibility & Instruction Clarity

1. **Unambiguous Formatting:** All skills, rules, templates, and prompts authored or updated by the AI MUST maintain high structural clarity, using standard Markdown headers, bullet points, and clean YAML frontmatter.
2. **Token Efficiency:** Bootstrapping contexts and registry indices MUST remain compact (~500 tokens per index file) to prevent token window starvation across open-source and local models (e.g., Llama 3, DeepSeek, Qwen).
3. **No Complex Nesting:** Avoid deeply nested or circular instruction loops that require massive frontier reasoning windows to decode. Keep execution workflows atomic (`Inputs -> Context -> Skills -> Rules -> Documents -> Review`).

---

## Article VI: Governance & Human Ownership (CODEOWNERS)

1. **Human Supremacy in Foundation:** All files under `ai/constitution/`, `ai/standards/`, `ai/ontology/`, and `ai/governance/` (Phase 0 & Phase 1) require explicit review and approval from designated human architects before merging.
2. **Autonomous Learning Boundaries:** The AI is permitted and encouraged to autonomously draft updates to `ai/memory/` (ADRs, Lessons Learned, Retrospectives) and `ai/knowledge_graph/` after workflow execution, provided they are submitted as standard pull requests.
3. **Stop & Escalate:** If an instruction contradicts this Constitution, or if the requirements are severely underspecified, the AI MUST halt execution and ask the human user for clarification using clear, structured questions.

---

## Summary Checklist for AI Bootstrapping

When booting into a session, every AI must verify:
- [ ] Have I loaded and understood `ai/constitution/core_constitution.md`?
- [ ] Have I identified the relevant domain vocabulary from `ai/ontology/`?
- [ ] Have I checked the hybrid index in `ai/registry/` for applicable skills and rules?
- [ ] Is my planned output fully traceable in `ai/knowledge_graph/`?
