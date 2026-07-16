---
id: review_performance
title: Prompt Wrapper - Review Performance & Database Query Efficiency
tier: 4_prompt_wrappers
domain: architecture
target_agent: ai/domains/architecture/agents/ai_reviewer.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: REVIEW PERFORMANCE & QUERY EFFICIENCY

This prompt wrapper coordinates the Automated Code Reviewer and Database Architect personas to audit code for latency, throughput, memory allocation, and query bottlenecks.

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA & Micro-Contexts
Read: `project_charter.md`, `universal_rules.md`, `backend_context.md`, `database_context.md`, `flutter_context.md`.

### Step 2: Execute Target Agent Personas
Activate `ai_reviewer.md` and `db_architect.md` to scan the target codebase:
1. **ORM & Query Efficiency (.NET):** Flag missing `.AsNoTracking()` on read queries, detect N+1 query execution loops inside loops, and verify explicit pagination (`Skip`/`Take`).
2. **Async/Await Concurrency:** Flag any synchronous locking (`.Result` or `.Wait()`) that causes thread pool starvation.
3. **Mobile Rendering Efficiency (Flutter):** Flag unbounded `Column`/`Row` lists; verify usage of `ListView.builder` with `itemExtent` or `AutoDisposeAsyncNotifierProvider` to prevent memory leaks.
4. **Caching Opportunities:** Identify frequently accessed, low-volatility data (e.g., tenant configs, asset categories) suitable for Redis caching.

### Step 3: Output Final Artifact
Emit the performance audit findings and exact refactored code blocks adhering to `ai/shared/output_format.md`.
