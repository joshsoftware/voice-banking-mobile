# Voice Banking Mobile

A Flutter-based voice banking application. This project is an exact functional copy of the https://github.com/joshsoftware/voice-banking, reimplemented with a **completely new UI** and modernised architecture. UI designs are available in [Figma](https://www.figma.com/make/Wj8Wbp0kntN6xzDp0MNwY2/Voice-Banking-App-Design?fullscreen=1&t=Z0jz6AgyUR6WolQr-1).

---

## Overview

The application provides voice banking capabilities, including voice recording, playback, and integration with banking services. The core features and behaviour mirror the reference app; the primary difference is a redesigned user interface implemented from scratch using a centralised design system.

---

## Tech Stack & Architecture

### Core Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| **Flutter** | 3.38.3 | Cross-platform UI framework with latest stable features, improved rendering, and tooling |
| **Dart** | 3.10.1 | Modern language features, stronger type safety, and performance optimisations |

### Architecture
- **Pattern:** MVVM (Model-View-ViewModel)
  - **Model:** Data and repositories
  - **View:** UI components
  - **ViewModel:** Business logic and state handling
  - Improves scalability, maintainability, and testability

### State Management
- **Riverpod** — Reactive, compile-safe state management with compile-time safety and no BuildContext dependency. Enables predictable updates, easy testing, and clear dependency injection. Providers scope data and logic, supporting async flows, caching, and seamless integration with the MVVM ViewModel layer.

### Navigation
- **go_router** (Navigator 2.0)
  - Declarative routing
  - Centralised route management
  - Deep linking support
  - Route guards for authentication

### Networking
- **Dio** — HTTP client with:
  - Interceptors
  - Global error handling
  - Timeout management
  - Multipart file uploads (voice files)
  - Retry support

### Theming & Design
- **Figma designs** — [Voice Banking App Design](https://www.figma.com/make/Wj8Wbp0kntN6xzDp0MNwY2/Voice-Banking-App-Design?fullscreen=1&t=Z0jz6AgyUR6WolQr-1) as the source of truth
- **Design system** — Centralised tokens and components
- **ThemeExtension** — Scalable, dynamic theming for consistency and easy brand updates

### Localization
- **gen_l10n** — Flutter built-in localisation:
  - ARB-based translation files
  - Type-safe strings
  - Multi-language support without hardcoded UI strings

### Local Storage
- **SharedPreferences** — Language, feature flags, and other user preferences

### Code Quality
- **flutter_lints** — Static analysis and consistent coding standards

### Firebase
- **Crashlytics** — Crash reporting
- **Remote Config** — Dynamic configuration without app updates

### Testing
- **Unit tests** — Business logic
- **Widget tests** — UI behaviour
- **Integration tests** — End-to-end flows

---

## Project Structure (Planned)

```
lib/
├── core/                 # Shared utilities, constants, extensions
├── data/                 # Models, repositories, data sources
├── features/             # Feature modules (MVVM per feature)
│   └── [feature]/
│       ├── model/
│       ├── view/
│       ├── view_model/
│       └── ...
├── l10n/                 # ARB localization files
├── routing/              # go_router configuration
├── theme/                # ThemeExtension, design tokens
└── main.dart
```

---

## Getting Started

### Prerequisites
- Flutter 3.38.3
- Dart 3.10.1

### Setup

```bash
# Install dependencies
flutter pub get

# Run code generation (if applicable)
flutter pub run build_runner build

# Run the app
flutter run
```

### Linting

```bash
flutter analyze
```

---

## Reference

This app replicates the functionality of the **voice-banking/mobile_app** project. The original app includes:
- Voice recording and playback
- Text-to-speech
- API integration via Dio
- Localization
- SharedPreferences for persistence
- Permission handling

All of the above will be reimplemented here with the new architecture and UI.

---

## Design

UI designs are in [Figma](https://www.figma.com/make/Wj8Wbp0kntN6xzDp0MNwY2/Voice-Banking-App-Design?fullscreen=1&t=Z0jz6AgyUR6WolQr-1). The implementation will follow the design system and use ThemeExtension for theming.

---

## License

TBD
