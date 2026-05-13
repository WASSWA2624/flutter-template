# Checklists and Final Standard

## Scope
Defines final review checklists for the reusable Flutter template.

## Starter readiness checklist
- Project structure follows `project_structure.md`.
- Architecture boundaries follow `architecture.md`.
- Dependencies follow `dependencies.md`.
- Theme supports light, dark, and system mode.
- Localization is configured with English as the initial locale.
- Responsive utilities and breakpoints are implemented.
- Shared components are minimal and consistent.
- Routing uses `go_router` and route guards are ready.
- State management uses Riverpod only.
- API, storage, offline, and auth contracts are ready without hard-coded product backend logic.
- Tests and CI commands are documented.

## Per-feature checklist
- Feature folder follows the standard structure.
- User-facing strings are localized.
- UI uses theme tokens and shared components.
- Loading, empty, error, and success states are handled.
- Forms validate and preserve recoverable input.
- Data models are mapped explicitly.
- Tests cover controller and critical UI behavior.

## Final standard
A developer or coding agent following the rules and dev plan must produce the same architecture, conventions, responsive behavior, theming behavior, and reusable component patterns.

## Related rules
- [`scope.md`](./scope.md)
- [`validation_report.md`](./validation_report.md)
- [`documentation_standards.md`](./documentation_standards.md)
