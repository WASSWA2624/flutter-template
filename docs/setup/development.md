# Development Setup

## Prerequisites

- Flutter 3.41 or newer on the stable channel.
- Android SDK for Android development.
- Xcode on macOS for iOS development.
- Xcode on macOS for macOS desktop development.
- Visual Studio with the C++ desktop workload for Windows desktop development.
- Linux desktop build dependencies on Linux for Linux desktop development.

## First run

```sh
flutter pub get
flutter test
flutter run -d chrome \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=http://localhost:8080
```

See `environment.md` for all supported public configuration keys.

## Test commands

```sh
flutter test
flutter test test/shared/layout
flutter test integration_test
flutter test integration_test -d <deviceId>
flutter test --coverage
```

Use `flutter test` for unit and widget coverage. Use
`flutter test integration_test` for startup and navigation smoke coverage that
uses provider overrides instead of production services. Add `-d <deviceId>`
when more than one Flutter device is available.

## Platform notes

- Android, iOS, Web, Windows, macOS, and Linux project files are generated in
  this repository.
- iOS and macOS builds must run on macOS with Xcode.
- Windows desktop builds must run on Windows with the Visual Studio C++ desktop
  workload.
- Linux desktop builds must run on Linux with the required GTK and CMake tools.

## Line endings

The repository uses LF line endings by default. Windows batch and PowerShell
files keep CRLF line endings for native shell compatibility.
