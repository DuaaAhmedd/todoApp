# Todo App

A Flutter todo application refactored to follow Clean Architecture and MVVM principles.

## Architecture Overview

This project follows Clean Architecture principles with MVVM (Model-View-ViewModel) pattern using BLoC/Cubit for state management, **refactored within the existing file structure**.

### Key Improvements

#### 1. Repository Pattern Enhancement
- **Singleton Pattern**: Repositories use singleton pattern to ensure single instance
- **Centralized Configuration**: API base URLs and endpoints centralized in repositories
- **Better Error Handling**: Comprehensive error handling with user-friendly messages
- **Token Management**: Automatic token storage and retrieval for authenticated requests

#### 2. MVVM Pattern Implementation
- **Separation of Concerns**: UI controllers moved from Cubits (ViewModel) to Views
- **Clean ViewModels**: Cubits now focus purely on business logic
- **Dependency Injection**: Repositories can be injected for testing

#### 3. Code Quality
- **Fixed Typo**: Corrected `accsess_token` to `access_token`
- **Removed TODOs**: Implemented token saving functionality
- **Better Naming**: Clear, descriptive variable names
- **Documentation**: Added comments explaining architecture decisions

### Project Structure

```
lib/
├── core/                          # Shared functionality
│   ├── helper/                    # Navigation, validation, popups
│   ├── utils/                     # Colors, constants
│   └── widgets/                   # Reusable widgets
├── features/
│   ├── auth/                      # Authentication feature
│   │   ├── cubit/                 # ViewModels (LoginCubit, RegisterCubit)
│   │   ├── data/
│   │   │   ├── models/            # Data models
│   │   │   └── repo/              # Repository with business logic
│   │   └── view/                  # UI layer with controllers
│   └── home/                      # Home/Tasks feature
│       ├── cubit/                 # ViewModels (GetTasksCubit, GetUserCubit)
│       ├── data/
│       │   ├── models/            # Data models
│       │   └── repo/              # Repository with business logic
│       └── view/                  # UI layer
└── main.dart                      # Application entry point
```

### Architecture Principles Applied

#### Repository Pattern
**Before:**
```dart
class AuthRepo {
  Dio dio = Dio(BaseOptions(...));  // New instance each time
  
  Future<Either<String, UserModel>> login(...) async {
    var response = await dio.post(
      'https://ntitodo-production-1fa0.up.railway.app/api/login',  // Hardcoded URL
      ...
    );
    // TODO: Save tokens
  }
}
```

**After:**
```dart
class AuthRepo {
  static final AuthRepo _instance = AuthRepo._internal();  // Singleton
  factory AuthRepo() => _instance;
  
  static const String _baseUrl = '...';  // Centralized config
  static const String _loginEndpoint = '/login';
  
  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl, ...));
  
  Future<Either<String, UserModel>> login(...) async {
    final response = await _dio.post(_loginEndpoint, ...);
    await _saveTokens(...);  // Implemented token saving
    return right(loginModel.user!);
  }
  
  Future<void> _saveTokens({String? accessToken, String? refreshToken}) async {
    // Token storage implementation
  }
}
```

#### MVVM Pattern
**Before:**
```dart
class LoginCubit extends Cubit<LoginState> {
  var username = TextEditingController();  // UI controller in ViewModel
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  void onLoginPressed() async {
    if (formKey.currentState?.validate() == true) {  // UI validation in ViewModel
      AuthRepo repo = AuthRepo();  // Direct instantiation
      var result = await repo.login(username: username.text, ...);
    }
  }
}
```

**After:**
```dart
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;
  
  LoginCubit({AuthRepo? authRepo})  // Dependency injection
      : _authRepo = authRepo ?? AuthRepo();
  
  Future<void> login({  // Pure business logic
    required String username,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result = await _authRepo.login(username: username, password: password);
    result.fold(
      (error) => emit(LoginErrorState(error)),
      (user) => emit(LoginSuccessState(user)),
    );
  }
}

// View manages its own controllers
class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

### Benefits

1. **Testability**: ViewModels can be tested with mock repositories
2. **Maintainability**: Clear separation between UI and business logic
3. **Scalability**: Easy to add new features following the same pattern
4. **Code Quality**: Better error handling and user feedback
5. **Performance**: Singleton repositories reduce memory overhead

### Running the Project

```bash
flutter pub get
flutter run
```

## Getting Started

This project is a Flutter application following Clean Architecture principles.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/).
