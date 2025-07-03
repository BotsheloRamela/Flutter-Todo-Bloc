# Flutter Todo App

A simple offline todo app built with Flutter. You can add, edit, delete, and mark todos as complete. 
Everything works offline and your data stays on your device.

## What's inside
* Flutter for the UI
* BLoC for state management
* Floor for local database storage
* Provider for dependency injection
* Clean Architecture with proper separation of layers

## Features
* ✅ Add new todos
* ✅ Edit existing todos
* ✅ Delete todos (swipe to delete)
* ✅ Mark todos as done/undone
* ✅ Everything works offline
* ✅ Data persists between app restarts

## How to run
* Make sure you have Flutter installed (channel stable, version `3.32.5`, or later)
* Clone this repo
* Run `flutter pub get` to install dependencies
* Run `flutter packages pub run build_runner build` to generate Floor database files
* Run `flutter run` to start the app

## Development scripts
The project includes helpful scripts for development:

### Generate Floor database files:
```bash
bash./scripts/run_build_runner.sh
```
### Clean up code:
```bash
./scripts/clean_code.sh
```
Automatically fixes imports, formats code, and runs analysis.

## Architecture
The app follows Clean Architecture principles with three main layers:

### Data Layer
* Floor Database: Stores todos locally with SQLite
* Repository: Handles data operations and error handling
* Models: Data transfer objects with JSON conversion

### Domain Layer
* Entities: Core business objects (Todo)
* Use Cases: Business logic for each operation
* Repository Interface: Contract for data operations

### Presentation Layer
* BLoC: Manages UI state and handles user events
* Pages: Main screens (todo list, add/edit form)
* Widgets: Reusable UI components

## Database
Uses Floor (SQLite) to store todos locally. Each todo has:
* `id` - unique identifier
* `title` - what you need to do
* `isCompleted` - whether it's completed
* `createdAt` - when you added it

## Development notes
This was built as a learning project to explore BLoC and Floor. Coming from Riverpod and Hive, the transition 
was interesting:

* BLoC vs Riverpod: BLoC is more explicit with events and states, while Riverpod feels more direct
* Floor vs Hive: Floor gives you proper SQL queries but requires more setup than Hive's simple key-value approach
* Clean Architecture: Still works great regardless of the state management solution

## Testing
Run tests with:
```bash
flutter test
```
The BLoC has unit tests covering the main use cases and state transitions.

## What I learned
* BLoC pattern is great for complex state management and testing
* Floor provides powerful database features but needs more boilerplate than Hive
* Clean Architecture makes switching between different tools much easier
* Provider still works well for dependency injection even with BLoC