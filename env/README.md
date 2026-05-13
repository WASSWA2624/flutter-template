# Flutter Define Files

These files contain public, non-secret compile-time values consumed through
`String.fromEnvironment`, `int.fromEnvironment`, and `bool.fromEnvironment`.

Run or build with Flutter's define file flag:

```sh
flutter run -d chrome --dart-define-from-file=env/development.json
flutter build web --release --dart-define-from-file=env/production.json
```

Do not store API keys, passwords, tokens, signing credentials, or private
certificates here. Use secure CI or platform secret storage for sensitive
values.
