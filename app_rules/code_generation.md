# Code Generation Strategy

## Owning Scope

This file defines generated code tools, commands, and generated file rules.

Dependencies are listed in [`dependencies.md`](./dependencies.md). Data modeling conventions are defined in [`data_modeling.md`](./data_modeling.md).

## Recommended Generated Code

Use generation for:

- Immutable state and models with `freezed`.
- JSON serialization with `json_serializable`.
- Riverpod providers with `riverpod_generator`.
- Drift database code with Drift tooling.
- Typed GoRouter routes when the app uses `go_router_builder`.

## Command

```bash
dart run build_runner build --delete-conflicting-outputs
```

For development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Generated File Rules

- Do not edit generated files manually.
- Commit generated files if the team standard requires it.
- Keep generator versions compatible.
- Run generation before tests in CI.
- Do not hide business logic inside generated code.
- Keep source files readable without opening generated files whenever possible.

## Common Generated Extensions

```txt
*.freezed.dart
*.g.dart
*.drift.dart
*.gr.dart
```

## Review Rule

Generated code should reduce boilerplate, not hide architecture mistakes.

If a generated abstraction makes boundaries unclear, simplify the design.


## Generation Governance

- Generated files should not be manually edited.
- Generation commands should be documented in the project README.
- CI should fail when generated files are stale.
- Keep generator versions compatible with the Dart and Flutter SDK constraints.
