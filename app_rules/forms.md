# Form Strategy

## Owning Scope

This file defines form composition and form UX rules.

Reusable form components are defined in [`reusable_components.md`](./reusable_components.md). Validation placement is defined in [`validation.md`](./validation.md).

## Form Principles

Forms should be:

- Consistent.
- Accessible.
- Localized.
- Responsive.
- Easy to validate.
- Safe from double-submit.
- Clear about required fields.
- Clear about submission state.

## Form Composition

Use reusable field components from the shared component system.

A feature form should usually contain:

```txt
FeatureForm widget
FeatureController
FeatureState
Field validators
Submit action
Localized messages
```

Example structure:

```txt
features/profile/presentation/widgets/profile_form.dart
features/profile/presentation/controllers/profile_controller.dart
features/profile/presentation/state/profile_state.dart
```

## Form Layout Rules

- Use one column on mobile.
- Use grouped sections for long forms.
- Use two-column layouts only when labels and fields remain readable.
- Keep primary actions easy to reach.
- Avoid fixed heights for form pages.
- Use max-width for desktop forms.

Responsive layout values are defined in [`responsive_adaptive_design.md`](./responsive_adaptive_design.md).

## Form UX Rules

- Show required field indicators consistently.
- Validate on submit at minimum.
- Use live validation only when it improves clarity.
- Keep submit buttons disabled when submission is clearly impossible.
- Show a loading state during submit.
- Prevent double submit.
- Keep server validation errors close to the affected field.
- Keep global submission errors near the form action area.
- Support keyboard submission where appropriate.

## Field State Rules

A field should be able to represent:

```txt
normal
focused
disabled
read-only
error
success when useful
loading when remote validation is used
```

## Form Accessibility

Every form should support:

- Keyboard navigation.
- Screen reader labels.
- Error announcements where possible.
- Clear focus order.
- Large enough tap targets.

Accessibility details are owned by [`accessibility.md`](./accessibility.md).


## Submission Rules

- Disable submit while an async submission is running.
- Prevent double submission.
- Preserve user input after validation failure.
- Map server validation errors back to the relevant fields when possible.
