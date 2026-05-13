# 23 - Final validation checklist

## Goal

Validate that the completed Flutter foundation is functional, minimal, complete, flexible, responsive, scalable, and aligned with the provided app rules.

## Applies app rules

- [`checklists.md`](../app-rules/checklists.md)
- [`validation_report.md`](../app-rules/validation_report.md)
- [`scope.md`](../app-rules/scope.md)
- All other rule files in [`app-rules/`](../app-rules/)
- Source blueprint: [`flutter-app-template.md`](../flutter-app-template.md)

## Foundation validation

Check that the template includes:

| Area | Required result |
|---|---|
| Project setup | Valid Flutter project with supported platform folders |
| Architecture | Feature-first layered architecture |
| Folder structure | `app/`, `core/`, `features/`, `shared/`, `l10n/`, tests, docs |
| Responsive system | Central breakpoints, `ResponsiveLayout`, `AppPage`, adaptive navigation |
| Routing | GoRouter with route names, paths, guards, and error route |
| Theme | Material 3, light/dark/system, light default, persisted mode |
| Localization | ARB setup, generated localization, no hard-coded user strings |
| Components | Minimal reusable components with theme/accessibility support |
| State | Riverpod providers, controllers, immutable state |
| API readiness | Dio wrapper, result/failure mapping, repository contracts |
| Storage | preferences, secure storage, database/cache boundaries |
| Offline readiness | sync queue scaffolding without backend lock-in |
| Auth readiness | backend-agnostic auth/session contracts |
| Security | no secrets, secure storage, sanitized logging |
| Error handling | AppFailure/AppResult, localized safe messages |
| Platform support | Android, iOS, Web, Linux, and desktop where applicable |
| Accessibility | semantics, focus, keyboard, touch target basics |
| Performance | const/lazy/rebuild/image rules documented and followed |
| Testing | unit, widget, responsive, localization, integration structure |
| CI/release | quality gates and platform build commands documented |
| Documentation | README, docs, ADRs, contribution workflow |

## Rule coverage map

Use this map to confirm every rules file was considered:

| Rule file | Covered mainly in dev-plan step |
|---|---|
| `accessibility.md` | 11, 18, 20 |
| `app_structure_example.md` | 06 |
| `architecture.md` | 03, 04, 13, 22 |
| `assets_branding.md` | 01, 04, 19 |
| `authentication_session.md` | 06, 07, 15 |
| `checklists.md` | 01, 22, 23 |
| `ci_cd_quality_gates.md` | 02, 20, 21 |
| `code_generation.md` | 02, 12, 20 |
| `coding_conventions.md` | 01, 03, 04, 22 |
| `database_strategy.md` | 14, 19 |
| `data_modeling.md` | 13, 14 |
| `date_time_formatting.md` | 10, 14 |
| `dependencies.md` | 01, 02, 19, 21 |
| `documentation_standards.md` | 04, 22 |
| `environment_configuration.md` | 05, 06, 15, 21 |
| `error_handling.md` | 06, 13, 17 |
| `feature_flags.md` | 05 |
| `feature_workflow.md` | 22 |
| `forms.md` | 10, 11, 16 |
| `localization_i18n.md` | 10, 11, 17, 20 |
| `multi_platform_input.md` | 07, 08, 18 |
| `navigation.md` | 07, 15 |
| `network_api.md` | 13, 16, 17 |
| `observability.md` | 06, 17 |
| `offline_sync.md` | 14 |
| `pagination_data_tables.md` | 13, 16 |
| `performance.md` | 12, 19 |
| `permissions.md` | 07, 15, 18 |
| `platform_guidelines.md` | 07, 18, 21 |
| `project_structure.md` | 01, 03, 04 |
| `repository_pattern_example.md` | 03, 13, 14 |
| `responsive_adaptive_design.md` | 07, 08, 11, 20 |
| `reusable_components.md` | 08, 09, 11, 16, 22 |
| `scalability.md` | 03, 19 |
| `scope.md` | 01, 23 |
| `search_filtering.md` | 16 |
| `security.md` | 05, 13, 15, 17, 21 |
| `startup_flow.md` | 05, 06, 17 |
| `state_management.md` | 03, 12, 20 |
| `storage_strategy.md` | 06, 09, 14, 15 |
| `testing.md` | 02, 20, 21 |
| `theming.md` | 08, 09, 11 |
| `validation.md` | 10, 15, 16 |
| `validation_report.md` | 01, 23 |

## Final commands

Run:

```bash
flutter pub get
dart format --set-exit-if-changed .
flutter analyze
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter test integration_test
flutter build web --release --dart-define=APP_ENV=production
flutter build linux --release --dart-define=APP_ENV=production
```

Also run Android/iOS/desktop builds on machines that support them:

```bash
flutter build apk --release --dart-define=APP_ENV=production
flutter build appbundle --release --dart-define=APP_ENV=production
flutter build ios --release --dart-define=APP_ENV=production
flutter build windows --release --dart-define=APP_ENV=production
flutter build macos --release --dart-define=APP_ENV=production
```

## Final acceptance criteria

- A developer can follow `dev-plan/01` through `dev-plan/23` in order.
- The result is a working reusable Flutter app foundation.
- The result remains backend-agnostic.
- The result supports the requested platforms and screen sizes.
- The result avoids unnecessary components and dependencies.
- The result is testable, documented, and ready for product-specific extension.
