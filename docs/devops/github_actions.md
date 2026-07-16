---
title: GitHub Actions CI/CD Pipeline Architecture - Field Service Platform (FSP)
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# GITHUB ACTIONS CI/CD PIPELINE ARCHITECTURE

## 1. Automated CI Workflow (`.github/workflows/ci.yml`)
Runs on every Pull Request targeting `main` or `develop`:
```yaml
name: FSP Enterprise CI Pipeline

on:
  pull_request:
    branches: [ "main", "develop" ]

jobs:
  backend-ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup .NET Core 8
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '8.0.x'
      - name: Restore NuGet Packages
        run: dotnet restore src/backend/FSP.sln
      - name: Build Clean Architecture Solution
        run: dotnet build src/backend/FSP.sln --no-restore --configuration Release
      - name: Run Unit & Containerized Integration Tests
        run: dotnet test src/backend/FSP.sln --no-build --configuration Release --verbosity normal /p:CollectCoverage=true

  mobile-ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Flutter Engine
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.x'
          channel: 'stable'
      - name: Install Dart Dependencies
        run: flutter pub get
        working-directory: src/flutter
      - name: Run Flutter Analyzer & Tests
        run: |
          flutter analyze
          flutter test --coverage
        working-directory: src/flutter
```
