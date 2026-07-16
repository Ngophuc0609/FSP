---
title: Multi-Stage Dockerfile & Containerization Standard
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# DOCKER CONTAINERIZATION STANDARD

## Production Multi-Stage Dockerfile (`src/backend/Dockerfile`)
To minimize image footprint (`< 180MB`) and secure production container execution under a non-root user (`appuser`), `FSP` uses multi-stage .NET 8 Alpine builds:

```dockerfile
# Stage 1: Build & Publish
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src
COPY ["src/backend/FSP.Api/FSP.Api.csproj", "FSP.Api/"]
COPY ["src/backend/FSP.Application/FSP.Application.csproj", "FSP.Application/"]
COPY ["src/backend/FSP.Domain/FSP.Domain.csproj", "FSP.Domain/"]
COPY ["src/backend/FSP.Infrastructure/FSP.Infrastructure.csproj", "FSP.Infrastructure/"]
RUN dotnet restore "FSP.Api/FSP.Api.csproj"
COPY src/backend/ .
WORKDIR "/src/FSP.Api"
RUN dotnet publish "FSP.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 2: Runtime Minimal Image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runtime
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "FSP.Api.dll"]
```
