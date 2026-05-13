# 22 - Documentation and feature workflow

## Goal

Create project documentation and a repeatable workflow for adding new features without breaking architecture, design, localization, testing, or security rules.

## Applies app rules

- [`documentation_standards.md`](../app-rules/documentation_standards.md)
- [`feature_workflow.md`](../app-rules/feature_workflow.md)
- [`checklists.md`](../app-rules/checklists.md)
- [`coding_conventions.md`](../app-rules/coding_conventions.md)
- [`architecture.md`](../app-rules/architecture.md)
- [`reusable_components.md`](../app-rules/reusable_components.md)

## Required documentation

Create or update:

```txt
README.md
docs/ARCHITECTURE.md
docs/ROUTING.md
docs/THEMING.md
docs/LOCALIZATION.md
docs/COMPONENTS.md
docs/AUTHENTICATION.md
docs/OFFLINE_SYNC.md
docs/API_INTEGRATION.md
docs/SECURITY.md
docs/TESTING.md
docs/CONTRIBUTING.md
docs/adr/
```

## README content

The root README should include:

- project purpose
- supported platforms
- setup commands
- environment configuration
- run commands
- build commands
- code generation commands
- testing commands
- folder structure summary
- architecture summary
- contribution rules

## ADRs

Use Architecture Decision Records for major decisions.

Example:

```txt
docs/adr/0001-use-riverpod-for-state-and-di.md
docs/adr/0002-use-go-router-for-navigation.md
docs/adr/0003-use-feature-first-architecture.md
```

Each ADR should include:

```txt
Status
Context
Decision
Consequences
```

## New feature workflow

For every new feature:

1. Create feature folder under `lib/features/<feature>/`.
2. Add domain contracts/entities only when needed.
3. Add data sources and repository implementations behind contracts.
4. Add use cases/controllers for state and actions.
5. Add pages/widgets using shared components.
6. Add route entries through central router.
7. Add localization keys.
8. Add permissions/feature flags only if needed.
9. Add tests.
10. Add feature README when the feature is non-trivial.

## Feature acceptance checklist

A feature is not complete until:

- imports follow architecture boundaries
- no user-facing strings are hard-coded
- UI works at required breakpoints
- loading/error/empty states exist where relevant
- form validation is localized where relevant
- API errors map to app failures
- tests cover success and failure paths
- accessibility basics are checked
- no secrets or private data are logged

## Code documentation

Use `///` comments for:

- public classes
- provider contracts
- extension methods
- complex shared widgets
- non-obvious algorithms

Do not over-document obvious private implementation details.

## Acceptance criteria

- Required docs exist.
- ADR folder exists with initial decisions.
- New feature workflow is documented.
- Feature checklist is available to coding agents.
- Documentation matches implemented structure.
