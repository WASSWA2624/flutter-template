# 01 - Project setup

## Goal

Create the base Flutter project and make it ready for consistent multi-platform development.

## Applies app rules

- `[scope.md](../app-rules/scope.md)`
- `[project_structure.md](../app-rules/project_structure.md)`
- `[platform_guidelines.md](../app-rules/platform_guidelines.md)`
- `[documentation_standards.md](../app-rules/documentation_standards.md)`

## Implementation tasks

1. Create or normalize the Flutter project root using the canonical structure.
2. Enable Android, iOS, Web, Windows desktop, macOS desktop, and Linux desktop targets where available.
3. Create `README.md`, `docs/`, `lib/`, `test/`, `integration_test/`, and `tool/` folders as required.
4. Keep the initial app minimal and runnable.
5. Confirm line endings and scripts are safe for Linux/macOS development environments.

## Expected output

- A clean Flutter project root.
- A minimal runnable app.
- Starter documentation with supported platforms and setup commands.

## Acceptance criteria

- `flutter pub get` succeeds.
- The project folder structure matches `project_structure.md`.
- No product-specific backend behavior is added.

## Coding-agent notes

- Do not skip rule references.
- Do not add product-specific behavior unless the step explicitly asks for it.

