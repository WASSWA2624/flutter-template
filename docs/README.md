# Documentation

This directory holds setup notes, architecture references, and decisions for the
Flutter template.

- `architecture/` explains the structure and major app boundaries.
  - `app-architecture.md` documents dependency direction, layer boundaries, and
    provider placement.
  - `performance-and-scalability.md` documents rebuild, list pagination,
    startup, and release-readiness checks.
  - `project-structure.md` documents the canonical repository layout.
- `decisions/` records architecture decisions that affect future work.
  - `0002-storage-and-offline-sync-foundation.md` documents Drift,
    preferences, secure storage, sync queue, and conflict boundaries.
- `setup/` contains local development and platform setup notes.
  - `environment.md` documents required public runtime configuration values.
  - `platform-behavior.md` documents safe areas, keyboard input,
    accessibility, and platform limitations.
- `release/` contains CI, build, versioning, and release readiness notes.
  - `build-ci-release.md` documents local quality gates, CI checks, platform
    release commands, and the release checklist.
