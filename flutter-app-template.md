# Reusable Flutter foundation for scalable multi-platform apps

## Architectural blueprint

The best foundation for this starter is a **feature-first, layered architecture**: keep **presentation/UI** organised by feature, keep **data access/integration code** behind repositories and services, enforce **unidirectional data flow**, and add a **domain layer only where business rules are genuinely complex**. That matches Flutter’s current architecture guidance: clear UI and data layers, repository pattern, immutable data, dependency injection, and tests are strongly recommended; a separate domain layer is conditional, not mandatory for every CRUD-heavy feature.

For a reusable starter, I would use an **MVVM-inspired presentation model** but implement it with **Riverpod notifiers/providers** rather than copying Flutter’s example `ChangeNotifier` stack literally. Flutter’s docs explicitly treat state-management choice as preference, while Riverpod gives you stronger linting, cleaner async state handling, and better test ergonomics. In practice, your “view model” becomes a feature-scoped provider/notifier that exposes immutable UI state and actions, while widgets stay mostly declarative and dumb.

The app should be split into four logical areas:

- **app shell**: bootstrap, routing, theme, localisation, environment config
- **core/shared**: cross-cutting concerns such as auth contracts, networking, storage abstractions, errors, responsive utilities, shared widgets
- **features**: vertical slices such as auth, dashboard, profile, settings, admin
- **tooling/docs/tests**: lints, build config, architecture docs, unit/widget/integration tests

This is intentionally **pragmatic**, not ceremony-heavy clean architecture. The starter should make small apps easy and large apps possible. If a feature is simple, presentation can talk straight to repositories. If a feature becomes complex, introduce use cases/domain services there only.

## Folder structure

Flutter’s architecture case study recommends combining **feature-based UI organisation** with **type-based shared data organisation**. For a reusable starter, I recommend this adapted structure.

```text
project_root/
├─ lib/
│  ├─ app/
│  │  ├─ bootstrap/
│  │  │  ├─ app_bootstrap.dart
│  │  │  ├─ app_initialiser.dart
│  │  │  └─ error_handlers.dart
│  │  ├─ config/
│  │  │  ├─ app_config.dart
│  │  │  ├─ env.dart
│  │  │  └─ flavour.dart
│  │  ├─ l10n/
│  │  │  ├─ app_en.arb
│  │  │  └─ generated/
│  │  ├─ router/
│  │  │  ├─ app_router.dart
│  │  │  ├─ app_routes.dart
│  │  │  ├─ route_guards.dart
│  │  │  └─ shell/
│  │  ├─ theme/
│  │  │  ├─ app_theme.dart
│  │  │  ├─ app_color_schemes.dart
│  │  │  ├─ app_text_theme.dart
│  │  │  ├─ app_component_themes.dart
│  │  │  ├─ theme_extensions.dart
│  │  │  └─ theme_mode_controller.dart
│  │  ├─ responsive/
│  │  │  ├─ breakpoints.dart
│  │  │  ├─ layout_size.dart
│  │  │  ├─ adaptive_scaffold.dart
│  │  │  └─ adaptive_spacing.dart
│  │  └─ app.dart
│  │
│  ├─ core/
│  │  ├─ auth/
│  │  │  ├─ domain/
│  │  │  ├─ application/
│  │  │  ├─ data/
│  │  │  └─ presentation/
│  │  ├─ errors/
│  │  ├─ logging/
│  │  ├─ network/
│  │  ├─ storage/
│  │  ├─ database/
│  │  ├─ localisation/
│  │  ├─ utils/
│  │  ├─ constants/
│  │  ├─ extensions/
│  │  └─ widgets/
│  │     ├─ app_button.dart
│  │     ├─ app_text_field.dart
│  │     ├─ app_select_field.dart
│  │     ├─ app_radio_group.dart
│  │     ├─ app_date_field.dart
│  │     ├─ app_dialogs.dart
│  │     ├─ app_loading_view.dart
│  │     ├─ app_error_view.dart
│  │     └─ app_empty_view.dart
│  │
│  ├─ features/
│  │  ├─ auth/
│  │  │  ├─ domain/
│  │  │  ├─ application/
│  │  │  ├─ data/
│  │  │  └─ presentation/
│  │  ├─ home/
│  │  ├─ profile/
│  │  ├─ settings/
│  │  └─ ...
│  │
│  ├─ main_development.dart
│  ├─ main_staging.dart
│  └─ main_production.dart
│
├─ test/
│  ├─ unit/
│  ├─ widget/
│  ├─ golden/
│  ├─ fixtures/
│  ├─ fakes/
│  └─ helpers/
│
├─ integration_test/
│
├─ docs/
│  ├─ architecture.md
│  ├─ conventions.md
│  ├─ testing.md
│  ├─ security.md
│  ├─ localisation.md
│  └─ adr/
│
├─ tooling/
│  ├─ ci/
│  └─ scripts/
│
├─ analysis_options.yaml
├─ build.yaml
├─ l10n.yaml
└─ pubspec.yaml
```

Two structural rules matter most. First, **shared cross-feature concerns** live in `app/` or `core/`, not inside a random feature. Second, **feature modules should not directly depend on each other’s internals**; if they must share something, promote it into `core/` or a local package later. This keeps features independently testable and stops the codebase turning into one large import graph. That follows Flutter’s separation-of-concerns guidance and its recommendation to standardise naming and app structure.

If this starter later becomes a company-wide standard used across many products, extract only the truly reusable parts into repo-local packages, for example `packages/design_system`, `packages/network_client`, or `packages/auth_adapter_oidc`. Do that **after reuse is proven**, not on day one. Over-extracting too early usually makes the base harder to evolve. This point is an engineering recommendation rather than a framework requirement. 

## Dependency stack

The dependency list should stay **tight, deliberate, and strongly justified**. Do **not** add a runtime responsive-framework package or a theme-framework package in the base starter; Flutter already gives you the primitives for adaptive layout, Material 3 components, theming, and localisation.

### Runtime dependencies

- Localisation: flutter_localizations and intl for generated app translations, built-in Material/Cupertino localisation delegates, and formatting.
- State and DI: flutter_riverpod and riverpod_annotation. Riverpod gives reactive caching, async handling, separation of logic from UI, testability, and generator support.
- Navigation: go_router for declarative routing, redirection, URL support, nested routes, and app-shell navigation with `ShellRoute`.
- Networking: dio because the base starter benefits from interceptors, cancellation, custom adapters, timeouts, and upload/download support out of the box.
- Models and serialisation: freezed_annotation and json_annotation for immutable models and predictable JSON contracts. Flutter’s architecture recommendations explicitly prefer immutable data models and recommend `freezed` or `built_value` for this job.
- Structured local data: drift and drift_flutter for the local database. Drift is reactive, works across native and web targets, supports migrations, and has modular generation for large projects.
- File paths: `path_provider` should be part of the starter whenever you need platform-specific database/cache locations; Drift’s own setup docs include it in the Flutter setup path.
- Simple preferences: shared_preferences for non-sensitive settings such as theme mode, locale override, feature-tour completion, or last-selected tab. Use the newer async/cache APIs, not the legacy API, and never store critical or sensitive data there.
- Connectivity signals: connectivity_plus, but only as a hint for sync policies; its own docs warn that connection type does not guarantee internet access.
- Sensitive storage: flutter_secure_storage for secrets/session artefacts on supported platforms, with the important web caveats covered below.
- Deep linking and external auth handoff: app_links and url_launcher for auth redirects, verification links, password-reset links, and standards-friendly login flows via the system browser.

### Dev dependencies

- Code generation: build_runner, riverpod_generator, freezed, json_serializable, and drift_dev.
- Linting: flutter_lints, riverpod_lint, and custom_lint. This combination gives you baseline Flutter/Dart rules plus Riverpod-specific static checks and space for project-specific rules, including a “no hard-coded user-facing strings in widgets” rule.
- Test tooling: `flutter_test` and `integration_test` from the Flutter SDK, plus mocktail for mocking. Add patrol only if your app must automate native permission dialogs or other platform UI; Flutter’s own testing docs recommend the SDK package first and Patrol only when native UI interaction is needed.

I would **not** bake a backend-specific auth SDK into the base starter. A reusable foundation should stay backend-agnostic. Put auth behind an `AuthRepository` contract, and choose the concrete adapter per product in a local package, such as `auth_adapter_oidc`, `auth_adapter_supabase`, or `auth_adapter_firebase`. That keeps the foundation reusable across different organisations and hosting stacks.

## Responsive layout and reusable UI system

Flutter distinguishes **responsive** design from **adaptive** design: responsive layout fits the UI into the available space, while adaptive behaviour changes structure and interaction so the UI is actually usable in that space. Your foundation should treat both as first-class concerns.

### Breakpoint policy

Flutter’s large-screen guidance says to base layout on the **window size**, not the physical device type, and to use tools like `MediaQuery`, `GridView`, and constrained/max-width layouts instead of device-name checks. Material’s layout guidance also expects navigation patterns to shift as space grows, for example bottom navigation on compact layouts and rail/drawer styles on larger layouts. Based on that guidance, I recommend this house breakpoint policy for the starter.

| Size class | Width | Recommended behaviour |
|---|---:|---|
| Small mobile | 0–359 | 1-column layout, compact spacing, bottom navigation or stacked routes, full-width forms |
| Medium mobile | 360–479 | 1-column layout, standard mobile spacing, bottom navigation |
| Large mobile | 480–599 | 1-column layout, larger gutters, wider cards/forms, bottom navigation |
| Tablet | 600–839 | possible 2-pane screens, navigation rail, side sheet/dialog patterns |
| Small desktop | 840–1199 | rail or permanent drawer, wider scaffold, constrained content width |
| Large desktop | 1200–1599 | 2–3 panel information layouts where useful, centred content, denser data views |
| Extremely large desktop | 1600+ | never stretch reading content edge to edge; increase panels only for data-dense workflows, otherwise increase margins and max widths |

The important part is not the exact numbers. The important part is the **policy**: never branch on “is tablet” or “is desktop” as your primary decision; branch on **available width/height** and the **interaction model** you need. Flutter explicitly warns against hard-coding columns or layout structure from device category, because multi-window mode and freely resized desktop/web windows make that unreliable.

### Layout rules

Every screen should follow these layout rules:

- Use `LayoutBuilder` and `MediaQuery.sizeOf(context)` to derive layout state.
- Use `ConstrainedBox`/`Container` `maxWidth` for forms, reading views, and settings pages so content stays readable on large screens.
- Use `SliverGridDelegateWithMaxCrossAxisExtent` or equivalent “max tile width” logic for grids and card galleries.
- Default to **one-column-to-many-columns scaling**, not separate screen implementations.
- Avoid locking orientation unless there is a genuine product constraint; Flutter’s large-screen guidance warns that orientation locks can cause poor foldable behaviour and letterboxing.

### Reusable component strategy

The UI library should be a **thin design-system wrapper over Flutter’s built-in Material 3 widgets**, not a set of bespoke components rewritten from scratch. Flutter’s Material widget catalogue is broad and Material 3 is the default design language; built-in components already give you strong behaviour across touch, mouse, and keyboard.

Build these shared wrappers in `core/widgets/`:

- `AppButton` with three semantic variants mapped to built-ins: **primary** → `FilledButton`, **secondary** → `OutlinedButton`, **tertiary** → `TextButton`.
- `AppTextField` built on `TextFormField`, with standard label/help/error/counter behaviour, input formatters, density, and validation timing.
- `AppSelectField<T>` built on `DropdownMenu<T>` instead of older dropdown patterns for searchable/filterable select experiences.
- `AppRadioGroup<T>` built on `RadioGroup` plus `RadioListTile` or `Radio`, so keyboard semantics and grouping are standardised.
- `AppSwitchField` and `AppCheckboxField` built on `SwitchListTile` / `CheckboxListTile`.
- `AppSegmentedControl<T>` built on `SegmentedButton<T>` for short exclusive option sets.
- `AppDateField` built on Flutter’s own date picker primitives: use `showDatePicker` for compact screens, and on larger screens present a standard dialog that embeds the built-in `CalendarDatePicker` / `InputDatePickerFormField` primitives behind the same wrapper API. That gives you uniform behaviour without inventing a new date system. Flutter’s date picker already supports locale, custom labels, and input/calendar modes.
- `AppDialog`, `AppBottomSheet`, `AppErrorView`, `AppEmptyView`, `AppLoadingView`, and `AsyncStateScaffold` wrappers so screen-state handling is consistent.

The rule is simple: **product code never styles raw widgets ad hoc**. Product screens use the shared wrappers or theme-configured Material widgets. That is how you keep uniformity across teams and future apps.

### Desktop, web, and accessibility behaviour

Because your target includes Windows and web, keyboard and pointer support are not optional. Flutter’s docs are explicit: users with physical keyboards expect tab traversal, focus highlights, and shortcuts; built-in controls mostly support this already, and custom widgets should use `FocusableActionDetector`, `Actions`, and `Shortcuts` where needed. Flutter also maps its semantics tree into an accessible DOM on web, so custom widgets need proper semantic roles and labels.

That means the starter should include:

- a shared shortcut map for common actions
- visible focus treatment in component themes
- semantic labels/hints on shared widgets
- mouse hover states, context menus, and tooltips where appropriate
- scroll, drag, and pane layouts that work with touch, mouse, and trackpad

## Theming and localisation

### Theming strategy

Your requirement is clear: **light theme must be the first-run default**, but the app must also support **dark** and **system** modes. Flutter supports this through `theme`, `darkTheme`, and `themeMode`; `ThemeMode.system` follows platform brightness, but Flutter’s own default is system mode, so your starter should explicitly override that and initialise first-run preference as `ThemeMode.light`.

The theme system should be token-driven:

- base colours from a brand seed or curated palette using `ColorScheme`
- typography, spacing, radius, stroke width, elevations, motion durations, and semantic colours stored centrally
- component themes for buttons, input decoration, chips, lists, cards, dialogs, navigation, and snack bars
- `ThemeExtension` for non-standard tokens such as spacing scales, app-specific status colours, chart tokens, or card variants

Flutter’s `ColorScheme` is the centre of Material 3 theming, and `ThemeExtension` exists specifically for custom theme additions with proper theme interpolation.

A good starter should therefore expose:

- `AppTheme.light()`
- `AppTheme.dark()`
- `AppThemeData` or `AppThemeTokens`
- `ThemeModeController` that persists the user choice
- `BrandThemeExtension`, `SpacingThemeExtension`, and `StatusThemeExtension`

Every shared component wrapper should consume these tokens. No screen should define its own brand colours, border radius, or custom spacing constants inline.

### Localisation strategy

Use Flutter’s built-in localisation toolchain, not a third-party i18n framework. Flutter’s current docs support ARB-based localisations with `flutter_localizations`, `l10n.yaml`, generated `AppLocalizations`, and generated `localizationsDelegates` / `supportedLocales`. Placeholders, plurals, and selects are all supported directly in ARB files.

For this starter:

- Add `lib/app/l10n/app_en.arb` immediately.
- Keep **English only during initial development**, but structure everything as multilingual from day one.
- Create **one ARB file per locale** when new languages are added.
- Never hard-code user-facing strings in widgets, view models, dialogs, snack bars, validation messages, or menus.
- Format dates, times, numbers, and currencies through `intl`.
- Shared wrappers like `AppDateField` and `AppDialog` must accept localisation keys or localised strings from `AppLocalizations`, never literals.

This matters especially for pickers and platform UI text. Flutter’s date picker accepts locale and label overrides like `helpText`, `cancelText`, `confirmText`, and error messages, so your shared wrapper should always supply those from localisation files.

## Authentication, security, and route protection

### Authentication model

The foundation should use a **standards-based auth design**, even if a concrete app later plugs in a vendor SDK. For native/public clients, current OAuth guidance is clear: use the **authorization code flow with PKCE**, treat native apps as **public clients**, and do not rely on embedded secrets or embedded web views. Native app authorization should go through an **external user-agent**, primarily the browser.

So the starter should define these contracts:

- `AuthRepository`
- `SessionRepository`
- `CurrentUserRepository`
- `AuthState` model: unauthenticated, authenticating, authenticated, refreshing, expired
- `AuthController` provider/notifier for login/logout/refresh/bootstrap
- `AuthGuard` for route redirection
- `AuthRedirectHandler` for link callback processing

Concrete provider integration belongs behind these contracts.

### Route protection

Use `go_router` for all app navigation and guard logic. It directly supports redirection and stable shell navigation via `ShellRoute`, which is ideal for an authenticated app shell where the navigation bar/rail/drawer remains visible while child content changes.

Recommended route layers:

- **public routes**: splash, sign-in, password reset, legal pages
- **auth callback route**: deep-link or browser return target
- **protected shell**: the main signed-in app, with shell navigation
- **fullscreen/protected leaf routes**: wizards, details, modals, subflows

The guard should depend only on auth state, not on widget context side effects.

### Token and session storage policy

Use the strictest storage policy that is realistic for each platform:

- **Access tokens**: prefer **memory-only** storage when possible.
- **Refresh tokens / session artefacts on native/desktop**: store in `flutter_secure_storage` if the chosen backend requires client-side refresh.
- **Web**: prefer a **BFF** or token-mediating backend with `HttpOnly`, `Secure`, `SameSite` cookies rather than storing long-lived tokens in browser-visible storage. The current browser-based OAuth guidance explicitly describes the BFF pattern and its cookie requirements.

This is especially important because `flutter_secure_storage` on web has real caveats: it requires HTTPS/localhost, uses an experimental WebCrypto implementation, and stores keys in browser storage on the same domain. That is acceptable for some lower-risk use cases, but it should **not** be your primary long-lived session strategy for serious web apps.

### Security rules the starter should enforce

- Never ship client secrets in the app binary; RFC 8252 is explicit that native apps cannot be treated as confidential clients in that way.
- Use PKCE with `S256`.
- Enforce exact redirect URIs.
- Use the external browser for sign-in on native/desktop.
- Protect sensitive data in storage and prevent leakage, in line with OWASP MASVS storage requirements.
- For browser sessions, use `HttpOnly`, `Secure`, `SameSite=Strict` cookies where possible. OWASP and the browser-based OAuth guidance both support this direction.
- Rotate refresh tokens or use sender-constrained refresh tokens for public clients, as required by current OAuth security best practice.
- Keep secrets out of `dart-define` values that ship to clients; use compile-time variables only for non-secret public configuration such as API base URLs, feature flags, and environment names. This follows from the public-client model above.

## Offline-first data strategy

The right default is **offline-capable, repository-driven, local-first reads**.

Flutter’s architecture guidance says the **repository is the source of truth** and should handle retry, caching, and offline synchronisation responsibilities. That is precisely the behaviour this starter should standardise.

### Recommended data flow

For most business features:

1. UI listens to repository-backed local state.
2. Repository reads/writes local database first.
3. Repository syncs with remote services when connectivity and auth allow.
4. UI shows sync state separately from data state.

That yields a stable UX: screens stay usable offline, data survives restarts, and network failures do not collapse the entire interface.

### Storage split

Use storage by responsibility:

- **Drift** for structured relational feature data, sync metadata, cached API entities, queues, and audit-like local records. Drift supports native desktop/mobile platforms and web, and its native implementation supports background isolates to keep database work off the UI isolate.
- **shared_preferences** only for simple, non-critical preferences. Its own docs warn not to use it for critical data, and new projects should prefer the newer async/cache APIs over the legacy one.
- **flutter_secure_storage** only for sensitive values such as session keys or encrypted refresh artefacts, with the web caveats already noted.

### Sync policy

The starter should include a shared sync framework with:

- read-through cache policy
- queued write operations for offline mutation
- conflict strategy per entity type
- `lastSyncedAt`, `syncState`, and `dirty` metadata
- sync triggers on app launch, resume, manual refresh, successful login, and connectivity changes

Do **not** make connectivity status your truth source. `connectivity_plus` explicitly warns that connectivity type does not guarantee real internet access, so every sync path still needs timeout/error handling and retry logic.

### Web offline support

If the web target truly needs offline capability, make that an explicit product decision. Flutter’s generated web service worker is deprecated; the docs now recommend either disabling it or building your own strategy. So for a serious offline-capable web app, use a deliberate service-worker/PWA approach rather than assuming the default build output will solve offline mode for you.

## Engineering standards, performance, and scalability rules

### Coding conventions

Use **Effective Dart** and enforce consistency mechanically. Good style, naming, and documentation reduce cognitive load across teams. For public API docs, use `///` doc comments so `dart doc` tooling can discover them. Flutter’s architecture docs also recommend standardised naming conventions such as `HomeScreen`, `HomeViewModel`, and `UserRepository`.

I recommend these project rules:

- `lower_snake_case.dart` for files
- `PascalCase` for types
- one primary public type per file
- suffixes by role: `Screen`, `Page`, `Controller`, `Repository`, `Service`, `Route`, `State`
- no business logic in widgets
- immutable UI state objects by default
- repositories exposed through abstract interfaces
- generated files (`*.g.dart`, `*.freezed.dart`) never edited manually
- no direct imports from one feature’s private implementation into another feature
- no user-facing string literals in product widgets

### Documentation standards

The starter should include documentation as part of the foundation, not as an afterthought:

- root `README.md`: setup, flavours, scripts, architecture summary
- `docs/architecture.md`: diagrams, layers, data flow, routing model
- `docs/conventions.md`: naming, widget rules, testing rules, state rules
- `docs/security.md`: token handling, storage, web/BFF policy, threat boundaries
- ADRs in `docs/adr/` for major structural choices
- `///` comments on public classes, provider contracts, extension methods, and complex shared widgets

That combination keeps the codebase understandable when many teams start using the same starter.

### Testing standards

Flutter’s architecture docs strongly recommend testing components separately and together: unit tests for services/repositories/view models, widget tests for views, and integration tests for complete flows. Flutter’s testing docs also distinguish clearly between unit, widget, and integration tests, and note that Patrol is useful only when native UI interaction is necessary.

Minimum testing bar for this starter:

- **Unit tests**: every repository, service, mapper, validator, and controller/notifier
- **Widget tests**: every shared component and every screen’s loading/empty/error/success states
- **Responsive widget tests**: key screens under compact, medium, and expanded widths
- **Theme tests**: light, dark, and high text-scale cases
- **Locale tests**: at least English now, plus structure to test additional locales later
- **Integration tests**: auth bootstrap, protected navigation, offline restore, sync recovery, theme switching, locale switching
- **Golden tests**: shared design-system widgets and especially critical responsive shells

### Performance guidelines

Flutter’s performance guidance is consistent on the basics:

- use `const` constructors as much as possible
- prefer reusable widgets over helper functions for UI chunks
- use builder constructors for large lists
- profile in **profile mode**, not debug mode
- use DevTools Performance View for mobile/desktop and Chrome DevTools for web
- do not block the UI thread/isolate with heavy work

Translate that into starter rules:

- default to `const` when possible
- break large screens into small reusable widgets/providers so rebuild scope stays narrow
- always use `ListView.builder` / lazy slivers for large datasets
- keep expensive DB work off the UI isolate; Drift’s native docs explicitly recommend background isolates for this reason
- avoid expensive visual effects unless they are worth the cost; Flutter warns that excessive `saveLayer()` use can cause jank
- run profile benchmarks for the core shell on web, Windows, Android, and iOS before product teams branch from the starter

### Scalability guidelines

For long-term growth, the starter should enforce these expansion rules:

- add a domain/use-case layer only where business complexity requires it
- split databases and generated code modularly when the schema grows; Drift’s modular code generation exists for large projects specifically because giant generated files slow builds and analysis
- keep repositories abstract so staging/dev/mock implementations are easy
- separate API DTOs from domain models once integrations become non-trivial
- extract repo-local packages only after reuse is real
- maintain migration tests for every DB schema change; Drift provides migration tooling and testing support for this exact problem

### Open questions and limitations

A few implementation choices still depend on product context rather than the starter itself:

- Whether the web app should be **fully offline/PWA-capable** or simply **offline-tolerant with cached local data**. Flutter’s generated service worker is deprecated, so full offline web support needs deliberate extra work.
- Which **auth adapter** each real app should use. The base starter should stay backend-agnostic; the app team should choose OIDC/BFF, Firebase, Supabase, or another provider separately.
- The exact **design tokens**: brand colours, typography scale, motion policy, and density policy. The structure above supports them, but the receiving organisation still needs to define them.

The most robust default, in one sentence, is this: **a feature-first Flutter starter built on layered repositories, Riverpod state/DI, go_router shell navigation, Drift local data, built-in Material 3 components, built-in localisation, strong linting/testing, standards-based auth, and local-first responsive UI wrappers**. That combination gives you the best balance of **uniformity, scalability, maintainability, security, and multi-platform fit** across Windows, iOS, Android, and web.