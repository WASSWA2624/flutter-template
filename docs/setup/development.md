# Development Setup

## Prerequisites

- Flutter 3.41 or newer on the stable channel.
- Android SDK for Android development.
- Xcode on macOS for iOS development.
- Xcode on macOS for macOS desktop development.
- Visual Studio with the C++ desktop workload for Windows desktop development.
- Windows Developer Mode for plugin symlink support on Windows desktop.
- Linux desktop build dependencies on Linux for Linux desktop development.

## First run

```sh
flutter pub get
flutter test
flutter run -d chrome --dart-define-from-file=env/development.json
flutter run -d windows --dart-define-from-file=env/development.json
```

See `environment.md` for all supported public configuration keys.

## Windows desktop

Windows desktop builds need both Flutter's Windows target and host-level build
support:

```powershell
flutter config --enable-windows-desktop
start ms-settings:developers
```

Enable Developer Mode in the settings window so Flutter plugins can create
symlinks. Install Visual Studio 2022 with the **Desktop development with C++**
workload, including its default MSVC, Windows SDK, and CMake components.

After those prerequisites are installed, verify the host and run the app:

```powershell
flutter doctor -v
flutter run -d windows --dart-define-from-file=env/development.json
```

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
- Windows desktop builds must run on Windows with Developer Mode enabled and
  the Visual Studio C++ desktop workload installed.
- Linux desktop builds must run on Linux with the required GTK and CMake tools.

## Line endings

The repository uses LF line endings by default. Windows batch and PowerShell
files keep CRLF line endings for native shell compatibility.
