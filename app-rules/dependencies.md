# Dependency Strategy

## Owning Scope

This file defines dependency selection, dependency categories, package commands, and package review rules.

Other files may mention a package they use, but this file owns the official dependency list.

## Dependency Principles

Use dependencies only when they solve a real architectural problem.

Rules:

- Prefer Flutter SDK components first.
- Prefer official Flutter/Dart packages where possible.
- Prefer mature packages with active maintenance.
- Avoid packages that duplicate simple Flutter functionality.
- Avoid UI kits that force the whole app into another design system.
- Wrap third-party packages behind your own services when they affect architecture.
- Keep optional packages optional.
- Review package health before adding it.
- Run dependency checks regularly.

## Core Dependencies

| Purpose | Recommended Dependency | Required? | Notes |
|---|---|---:|---|
| State management and dependency injection | `flutter_riverpod` | Yes | Main app state and dependency injection |
| Riverpod annotations | `riverpod_annotation` | Recommended | Cleaner provider code generation |
| Routing | `go_router` | Yes | Declarative routing, deep links, route guards |
| HTTP client | `dio` | Yes | Interceptors, cancellation, timeouts, upload/download |
| Localization | `flutter_localizations` | Yes | Flutter SDK localization support |
| Internationalization helpers | `intl` | Yes | Dates, numbers, messages |
| Secure storage | `flutter_secure_storage` | Yes | Sensitive session values |
| Local database | `drift` | Yes for offline-capable apps | Typed SQLite access |
| Flutter Drift setup | `drift_flutter` | Recommended | Easier database setup across platforms |
| SQLite native libraries | `sqlite3_flutter_libs` | Usually | Native SQLite support |
| Preferences | `shared_preferences` | Yes | Non-sensitive app settings |
| Connectivity | `connectivity_plus` | Yes | Network type awareness |
| File paths | `path_provider` | Yes | Platform-specific local paths |
| Path utilities | `path` | Yes | Safe path handling |
| Immutable models | `freezed_annotation` | Recommended | Immutable states, unions, `copyWith` |
| JSON mapping | `json_annotation` | Recommended | Typed JSON serialization |
| App metadata | `package_info_plus` | Recommended | Version and package info |
| URL opening | `url_launcher` | Optional but common | External links |
| Logging | `logging` | Recommended | Structured app logging |
| Collection helpers | `collection` | Optional | Useful equality and collection helpers |

## Development Dependencies

| Purpose | Recommended Dependency | Required? |
|---|---|---:|
| Flutter tests | `flutter_test` | Yes |
| Integration tests | `integration_test` | Yes |
| Mocking | `mocktail` | Recommended |
| Code generation | `build_runner` | Recommended |
| Freezed generation | `freezed` | Recommended |
| JSON generation | `json_serializable` | Recommended |
| Riverpod generation | `riverpod_generator` | Recommended |
| Riverpod linting | `riverpod_lint` | Recommended |
| Base linting | `flutter_lints` | Yes |
| Stricter linting | `very_good_analysis` | Optional |
| Golden testing | `golden_toolkit` | Optional but useful |

## Optional Dependencies

Add these only when the product needs them.

| Need | Optional Dependency | Notes |
|---|---|---|
| Desktop window sizing | `window_manager` | Useful for Windows apps with minimum window sizes |
| SVG assets | `flutter_svg` | Use only if SVG assets are required |
| Cached network images | `cached_network_image` | Useful for image-heavy apps |
| File picking | `file_picker` | Use only for upload/import features |
| Local biometric authentication | `local_auth` | Use only for biometric unlock flows |
| Runtime permissions | `permission_handler` | Use only when app needs camera, photos, location, etc. |
| Type-safe GoRouter routes | `go_router_builder` | Useful for larger apps |
| Native integration testing | `patrol` | Useful when testing permission dialogs or native UI |
| Monorepo management | `melos` | Use only when splitting into packages |
| Launcher icons | `flutter_launcher_icons` | Branding setup |
| Splash screen | `flutter_native_splash` | Branding setup |
| Crash reporting | Product-specific | Use an abstraction before integrating |
| Analytics | Product-specific | Use an abstraction before integrating |

## Installation Commands

Use commands instead of copying outdated version numbers.

```bash
flutter pub add flutter_riverpod riverpod_annotation go_router dio intl flutter_secure_storage drift drift_flutter sqlite3_flutter_libs shared_preferences connectivity_plus path_provider path freezed_annotation json_annotation package_info_plus url_launcher logging collection
```

```bash
flutter pub add --dev build_runner freezed json_serializable riverpod_generator riverpod_lint flutter_lints mocktail golden_toolkit
```

For SDK packages, add them in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
```



## Versioning Rules

- Do not hard-code package versions inside these convention files.
- Use `flutter pub add` for current compatible versions.
- Review `pubspec.lock` in applications, but do not copy one app's lockfile into a reusable starter unless the starter is meant to be a template with exact pinned versions.
- Run `flutter pub outdated` during maintenance.
- Upgrade major versions intentionally and read changelogs before accepting breaking changes.

## Dependency Review Checklist

| Question | Required Answer |
|---|---|
| Does Flutter already provide this? | No, or the package adds real value |
| Is the package maintained? | Yes |
| Does it support Android, iOS, Web, and Windows? | Yes, unless intentionally platform-specific |
| Does it affect architecture? | If yes, wrap it behind an interface |
| Does it increase app size significantly? | Acceptable for the value it provides |
| Does it access sensitive data? | Reviewed carefully |
| Is it easy to replace? | Ideally yes |

## Removal Rule

A dependency should be removed when it is no longer used, no longer maintained, fails platform support, or can be replaced by a simpler Flutter SDK solution.


## Connectivity Rule

Connectivity is a signal, not proof that the internet is reachable. The app must still handle request timeouts, DNS failures, captive portals, and backend errors in the network layer.
