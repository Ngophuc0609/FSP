---
ontology_id: ONT-OPS-001
category: DevOps & Cloud Domain Vocabulary
status: Active
version: 1.0.0
owner: Principal DevOps & SRE Lead
last_updated: 2026-07-15
terms:
  - id: TRM-OPS-001
    term: CI/CD Pipeline
    definition: "Continuous Integration and Continuous Delivery automation workflows responsible for building, testing, auditing, and deploying code artifacts across environments."
    attributes: [pipeline_id, trigger_events, build_stages, test_gates, deployment_targets]

  - id: TRM-OPS-002
    term: Environment
    definition: "A completely isolated runtime infrastructure tier hosting deployed application services, databases, and configurations."
    attributes: [env_name, [Local, Development, Staging, Production], isolation_level, secrets_vault]

  - id: TRM-OPS-003
    term: Infrastructure as Code (IaC)
    definition: "The practice of managing and provisioning cloud compute, networking, and storage resources through machine-readable definition files (e.g., Terraform or Bicep)."
    attributes: [provider, state_file, module_registry, compliance_scan]

  - id: TRM-OPS-004
    term: Containerization & Orchestration
    definition: "Packaging application services into immutable Docker images and deploying them via Kubernetes cluster orchestration."
    attributes: [dockerfile, container_image, k8s_deployment, pod, service, ingress]

  - id: TRM-OPS-005
    term: Service Level Objective (SLO) & Service Level Indicator (SLI)
    definition: "Quantifiable reliability metrics (SLIs like API latency < 200ms) and target success thresholds (SLOs like 99.9% uptime) defining operational health."
    attributes: [metric_name, threshold, error_budget, alert_rule]
---

# DevOps & Cloud Ontology

## Overview
This file establishes canonical SRE, DevOps, and Infrastructure terminology. AI DevOps agents (`devops_engineer`, `sre`, `release_manager`) must adhere to these definitions when generating CI/CD YAML configurations, Dockerfiles, Terraform scripts, or operational runbooks.

## Infrastructure Rules & Standards

### 1. Immutable Infrastructure & Zero-Secret Commits
- All deployment environments must be provisioned via IaC. Manual configuration changes on production servers are strictly prohibited.
- Secrets, certificates, and passwords MUST be injected dynamically at runtime from Azure Key Vault or AWS Secrets Manager. Never store raw credentials in CI/CD scripts or Dockerfiles.

### 2. Multi-Stage Dockerfile Standard
- All `.NET` backend services and web applications must use multi-stage Docker builds:
  - Stage 1: Build & Test (SDK image)
  - Stage 2: Publish optimized binary
  - Stage 3: Runtime minimal image (Alpine or Distroless) running as non-root user.
