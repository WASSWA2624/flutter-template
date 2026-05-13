# Scalability Strategy

## Owning Scope

This file defines how the app should scale from small to large projects and which anti-patterns to avoid.

Architecture rules are defined in [`architecture.md`](./architecture.md). Feature workflow is defined in [`feature_workflow.md`](./feature_workflow.md).

## Scaling From Small to Large Apps

Start simple, but keep boundaries clean.

Small app:

```txt
Few features
Simple repositories
Small local storage needs
Basic auth
```

Large app:

```txt
Many features
Multiple data sources
Offline sync
Permissions
Feature flags
More tests
More documentation
```

The same architecture should support both.

## Scaling Rules

- Keep features independent.
- Keep `core` generic.
- Extract shared behavior only after repeated use.
- Split large features into subfeatures when needed.
- Use package or monorepo structure only when feature count and team size justify it.
- Add ADRs for major architecture changes.
- Keep dependencies replaceable through wrappers.

## Avoid These Problems

| Problem | Result |
|---|---|
| One giant global state | Hard rebuild control and hard tests |
| One giant services folder | Unclear ownership |
| API calls in widgets | Hard to test and hard to reuse |
| DTOs used everywhere | API shape leaks into app |
| Feature logic in `core` | `core` becomes a dumping ground |
| Hard-coded text/styles/routes | Inconsistent UI and harder maintenance |
| No route guards | Security and navigation bugs |
| No offline boundary | Cache and sync logic spreads everywhere |

## Monorepo Threshold

Consider a package/monorepo structure when:

- Multiple apps share the same core package.
- The team needs independent package ownership.
- Features are large enough to become reusable packages.
- CI times need package-level optimization.

Do not split into packages too early. Package boundaries add overhead.


## Package Boundary Rule

Do not split into packages too early. Move code into packages only when ownership, reuse, release management, or build performance clearly benefits from the split.
