# Dependency Strategy

## Scope
Defines the approved starter dependencies and when each dependency may be used.

## Runtime dependencies
| Purpose | Package | Rule |
|---|---|---|
| State and DI | `flutter_riverpod`, `riverpod_annotation` | Use for app state, feature state, dependency injection, async state, and provider overrides. |
| Navigation | `go_router` | Use for all navigation, route guards, deep links, and web URLs. |
| Networking | `dio` | Use for HTTP clients, interceptors, timeouts, cancellation, and API error mapping. |
| Models | `freezed_annotation`, `json_annotation` | Use for immutable models and JSON DTOs where generation is valuable. |
| Local database | `drift`, `drift_flutter` | Use for structured local data, offline cache, and sync queues. |
| Simple settings | `shared_preferences` | Use only for non-sensitive preferences such as theme mode and locale. |
| Secure storage | `flutter_secure_storage` | Use for tokens or secrets on supported platforms. |
| Connectivity hint | `connectivity_plus` | Use only as a signal, not proof that the internet works. |
| Paths | `path_provider` | Use for platform-specific database/cache paths. |
| External links | `url_launcher`, `app_links` | Use for deep links, browser auth handoff, and external URLs. |
| Localization | `flutter_localizations`, `intl` | Use generated localizations and locale-aware formatting. |

## Dev dependencies
| Purpose | Package |
|---|---|
| Code generation | `build_runner`, `riverpod_generator`, `freezed`, `json_serializable`, `drift_dev` |
| Lints | `flutter_lints`, `riverpod_lint`, `custom_lint` |
| Testing | `flutter_test`, `integration_test`, `mocktail` |

## Mandatory rules
- Do not add a dependency when Flutter SDK widgets or Dart standard libraries are enough.
- Do not add duplicate packages for the same responsibility.
- Every new dependency must have a clear owner, purpose, and platform compatibility check.
- Keep dependencies compatible with all supported platforms.
- Avoid packages that are abandoned, unmaintained, or platform-limited unless the app-specific requirement justifies them.
- Do not put secrets in `pubspec.yaml`, assets, source code, or test fixtures.

## Acceptance checklist
- `pubspec.yaml` contains only approved general-purpose starter packages.
- Generated-code dependencies are separated into `dev_dependencies` where appropriate.
- Dependency decisions are documented in README or an ADR when they affect architecture.

## Related rules
- [`code_generation.md`](./code_generation.md)
- [`platform_guidelines.md`](./platform_guidelines.md)
- [`security.md`](./security.md)
- [`ci_cd_quality_gates.md`](./ci_cd_quality_gates.md)
