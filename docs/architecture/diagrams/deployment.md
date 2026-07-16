---
title: Deployment Architecture Diagram - Field Service Platform (FSP)
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# DEPLOYMENT ARCHITECTURE DIAGRAM

## Cloud Infrastructure Topography (`Azure / Production`)

```mermaid
graph TD
    subgraph Client [Client Devices]
        MOB[Field Technician Mobile<br/>iOS / Android via App Stores]
        BROWSER[Dispatcher Web Browser<br/>HTTPS]
    end
    
    subgraph Edge [Edge & CDN Layer]
        CF[Cloudflare CDN & WAF<br/>DDoS Protection & SSL Termination]
    end
    
    subgraph Azure_Cloud [Microsoft Azure Cloud Platform]
        subgraph App_Cluster [App Service / Container Apps Cluster]
            API_INST1[.NET Core API Instance 1<br/>Docker Container]
            API_INST2[.NET Core API Instance 2<br/>Docker Container]
        </subgraph
        
        subgraph Data_Tier [Persistence & Caching Tier]
            SQL_DB[(Azure SQL Database<br/>Multi-Tenant Elastic Pool)]
            REDIS_CACHE[(Azure Cache for Redis<br/>Distributed Memory)]
            BLOB[(Azure Blob Storage<br/>High-Res Inspection Photos)]
        end
    end
    
    MOB -->|HTTPS / REST| CF
    BROWSER -->|HTTPS / REST / WebSockets| CF
    CF -->|Load Balanced Traffic| API_INST1
    CF -->|Load Balanced Traffic| API_INST2
    API_INST1 & API_INST2 -->|TDS / Parameterized SQL| SQL_DB
    API_INST1 & API_INST2 -->|StackExchange.Redis| REDIS_CACHE
    API_INST1 & API_INST2 -->|SAS Token Uploads| BLOB
```
