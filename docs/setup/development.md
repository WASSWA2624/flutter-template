# Development Setup

## Prerequisites

- Flutter 3.41 or newer on the stable channel.
- Android SDK for Android development.
- Xcode on macOS for iOS development.
- Linux desktop build dependencies on Linux for Linux desktop development.

## First run

```sh
flutter pub get
flutter test
flutter run -d chrome
```

## Platform notes

- Android, Web, and Linux project files are generated in this repository.
- iOS project files are generated, but builds must run on macOS with Xcode.
- Linux desktop builds must run on Linux with the required GTK and CMake tools.

## Line endings

The repository uses LF line endings by default. Windows batch and PowerShell
files keep CRLF line endings for native shell compatibility.
