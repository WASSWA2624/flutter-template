# Documentation Standards

## Owning Scope

This file defines project documentation, README content, architecture decision records, and code documentation rules.

This modular documentation package follows the same principle: one topic per file, with links instead of duplicate definitions.

## Required Documentation Files

A reusable foundation should include:

```txt
README.md
ARCHITECTURE.md
THEMING.md
LOCALIZATION.md
COMPONENTS.md
AUTHENTICATION.md
OFFLINE_SYNC.md
API_INTEGRATION.md
TESTING.md
CONTRIBUTING.md
```

As the app grows, add focused documentation instead of expanding one large file endlessly.

## README Content

The project README should include:

```txt
Project overview
Supported platforms
Setup instructions
Environment configuration
How to run the app
How to run tests
Folder structure
Development rules
```

## Architecture Decision Records

Use ADRs for important technical decisions.

```txt
docs/adr/
  0001-use-riverpod.md
  0002-use-go-router.md
  0003-use-drift-for-local-database.md
```

ADR template:

```md
### ADR 0001: Use Riverpod

## Status
Accepted

## Context
Why a decision is needed.

## Decision
What was chosen.

## Consequences
Tradeoffs and impact.
```

## Code Documentation

Document public APIs, reusable components, and complex business logic.

Example:

```dart
/// A reusable app button used across all screens.
///
/// Supports loading, disabled, and responsive states.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;
}
```

Avoid documenting obvious code.

Bad:

```dart
// Sets the email
email = value;
```

Good:

```dart
// Normalizes email before validation to avoid duplicate account checks.
email = value.trim().toLowerCase();
```

## Documentation Rules

- Keep documentation close to the topic it describes.
- Link to existing definitions instead of repeating them.
- Update docs when architecture changes.
- Use examples for conventions that developers must follow.
- Keep onboarding instructions clear enough for a new developer.


## Documentation Ownership Rule

When a rule already exists in this app rules package, project documentation should link to the owning convention instead of copying it in full.
