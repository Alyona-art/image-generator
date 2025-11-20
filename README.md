# Image Generator App

A Flutter app that generates images from text descriptions. This is a test task demonstrating modern Flutter architecture and best practices.

## What It Does

The app has two screens:
1. **Prompt screen** - Enter a description of the image you want
2. **Result screen** - Shows the generated image (or loading/error states)

You can generate multiple images, retry on errors, and navigate back while keeping your original prompt.

## Architecture

The code is organized into **features** (prompt, result) and **core** (shared stuff like routing and repositories). Each feature has its own state management (BLoC) and UI components.

**State Management**: Uses BLoC pattern - keeps UI and business logic separate, makes state changes predictable.

**Dependency Injection (DI)**: This is a way to provide dependencies (like repositories) to classes that need them, instead of having those classes create dependencies themselves.

**Navigation**: Uses GoRouter for type-safe navigation between screens.

**Repository Pattern**: The data layer (repository) is separate from the UI. Currently uses a mock that simulates API calls, but can be easily replaced with a real API.

## Tech Stack

- Flutter with BLoC for state management
- Injectable/GetIt for dependency injection
- GoRouter for navigation
- Freezed for immutable state classes
- Material 3 design with dark mode

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Generate code (for freezed and injectable):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/             # Shared infrastructure
│   ├── di/           # Dependency injection setup
│   ├── repository/   # Data layer (currently mock)
│   ├── router/       # Navigation
│   └── widgets/      # Reusable components
└── features/         # Feature modules
    ├── prompt/       # Prompt input screen
    └── result/       # Result display screen
```

Each feature contains its own BLoC, UI, and widgets - everything it needs to work independently.

The repository currently simulates API calls with random delays and occasional failures to demonstrate error handling.
