# Todo App

A Flutter todo application built with Clean Architecture and MVVM pattern.

## Architecture

This project follows Clean Architecture principles with MVVM (Model-View-ViewModel) pattern using BLoC/Cubit for state management.

### Project Structure

```
lib/
├── core/                          # Core functionality shared across features
│   ├── error/                     # Error handling (Failures)
│   ├── network/                   # Network configuration (API constants, DioClient)
│   ├── usecases/                  # Base UseCase class
│   ├── utils/                     # Utilities (Colors, etc.)
│   ├── helper/                    # Helper classes (Navigation, Validation, Popups)
│   └── widgets/                   # Reusable widgets
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── data/                  # Data layer
│   │   │   ├── datasources/       # Remote data sources
│   │   │   ├── models/            # Data models
│   │   │   └── repo/              # Repository implementations
│   │   ├── domain/                # Domain layer
│   │   │   ├── entities/          # Business entities
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   └── usecases/          # Use cases
│   │   ├── cubit/                 # Presentation layer - State management
│   │   └── view/                  # Presentation layer - UI
│   └── home/                      # Home feature
│       ├── data/                  # Data layer
│       ├── domain/                # Domain layer
│       ├── cubit/                 # Presentation layer - State management
│       └── view/                  # Presentation layer - UI
└── main.dart                      # Application entry point
```

### Clean Architecture Layers

#### 1. Domain Layer (Business Logic)
- **Entities**: Core business objects (User, Task)
- **Repository Interfaces**: Contracts for data operations
- **Use Cases**: Business logic operations

#### 2. Data Layer (Data Management)
- **Data Sources**: API clients and local storage
- **Models**: Data transfer objects extending domain entities
- **Repository Implementations**: Concrete implementations of repository interfaces

#### 3. Presentation Layer (UI)
- **Views**: Flutter widgets
- **Cubits**: State management using BLoC pattern
- **States**: UI state definitions

### Key Principles

1. **Dependency Injection**: Dependencies are injected through constructors
2. **Separation of Concerns**: Each layer has a specific responsibility
3. **Testability**: Easy to test each layer independently
4. **Scalability**: Easy to add new features following the same pattern

### State Management

This app uses **flutter_bloc** package with Cubit for state management:
- Cubits contain business logic and emit states
- Views listen to state changes and rebuild accordingly
- Controllers are managed in views, not in Cubits

### Error Handling

Uses **dartz** package for functional error handling:
- `Either<Failure, Success>` for operations that can fail
- Custom Failure classes (ServerFailure, NetworkFailure, CacheFailure)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
