---
applyTo: '**'
---
Provide project context and coding guidelines that AI should follow when generating code, answering questions, or reviewing changes.

# Copilot Instructions for Flutter Development

## Project Overview
This document provides guidelines for developing Flutter applications using industry-standard practices, architectural patterns, and development methodologies.

## Core Principles

### 1. Architecture
- **Follow Clean Architecture**: Separate concerns into layers (Presentation, Domain, Data)
- **Use BLoC Pattern**: Implement Business Logic Components for state management
- **Apply SOLID Principles**: Write maintainable, testable, and scalable code
- **Dependency Injection**: Use get_it or similar for dependency management

### 2. Project Structure
```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── themes/
│   ├── utils/
│   └── usecases/
├── features/
│   └── [feature_name]/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── shared/
│   ├── widgets/
│   ├── utils/
│   └── constants/
└── main.dart
```

## Development Guidelines

### 1. Code Style & Formatting
- **Use dart format**: Always format code with `dart format .`
- **Follow Effective Dart**: Adhere to official Dart style guide
- **Use meaningful names**: Variables, functions, and classes should be descriptive
- **Add documentation**: Use /// for public APIs and complex logic

```dart
/// Represents a user authentication result
class AuthResult {
  const AuthResult({
    required this.isSuccess,
    required this.user,
    this.errorMessage,
  });

  final bool isSuccess;
  final User? user;
  final String? errorMessage;
}
```

### 2. State Management
- **Prefer BLoC/Cubit**: Use flutter_bloc for state management
- **Immutable State**: Always use immutable state classes
- **Event-Driven**: Handle user interactions through events

```dart
// State
@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);
  final User user;
  
  @override
  List<Object?> get props => [user];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  final AuthRepository authRepository;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
```

### 3. Widget Development
- **Prefer StatelessWidget**: Use when state management isn't needed
- **Extract Widgets**: Break down complex UIs into smaller, reusable widgets
- **Use const constructors**: Improve performance with const widgets
- **Responsive Design**: Use LayoutBuilder, MediaQuery for responsive UIs

```dart
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(text),
    );
  }
}
```

### 4. Data Layer
- **Repository Pattern**: Abstract data sources behind repositories
- **Data Models**: Separate models from domain entities
- **Error Handling**: Implement comprehensive error handling

```dart
// Data Model
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}

// Repository Implementation
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<User> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      await localDataSource.cacheUser(userModel);
      return userModel;
    } on ServerException {
      throw ServerFailure();
    } on CacheException {
      throw CacheFailure();
    }
  }
}
```

### 6. Performance Optimization
- **Use const constructors**: Reduce widget rebuilds
- **ListView.builder**: For large lists
- **Image caching**: Use cached_network_image
- **Lazy loading**: Implement pagination for large datasets

### 7. Error Handling
- **Custom Exceptions**: Create specific exception types
- **Failure Classes**: Use failure classes for error states
- **User-friendly Messages**: Display meaningful error messages

```dart
abstract class Failure extends Equatable {
  const Failure();
  
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}
class CacheFailure extends Failure {}
class NetworkFailure extends Failure {}

// Error handling in BLoC
Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  
  final result = await authRepository.login(event.email, event.password);
  
  result.fold(
    (failure) => emit(AuthError(_mapFailureToMessage(failure))),
    (user) => emit(AuthSuccess(user)),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server error occurred. Please try again.';
    case NetworkFailure:
      return 'No internet connection. Please check your network.';
    default:
      return 'An unexpected error occurred.';
  }
}
```

## Dependencies

### Essential Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: 
  equatable: 
  
  # Dependency Injection
  get_it:
  injectable: 
  
  # HTTP & Networking
  dio: 
  retrofit: 
  
  # Local Storage
  shared_preferences: 
  hive: 
  hive_flutter: 
  
  # Utilities
  dartz: 
  freezed_annotation: 
  json_annotation: 
  
  # UI
  cached_network_image: 
  shimmer: 
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Code Generation
  build_runner: 
  freezed: 
  json_serializable: 
  injectable_generator: 
  retrofit_generator: 
  
  # Testing
  bloc_test: 
  mocktail: 
  
  # Linting
  flutter_lints:
```

### Architecture Packages
- **BLoC**: State management
- **Get It**: Dependency injection
- **Dartz**: Functional programming utilities
- **Freezed**: Immutable data classes
- **Injectable**: Code generation for DI

## Security Guidelines

### 1. API Security
- **Use HTTPS**: Always use secure connections
- **Token Management**: Store tokens securely using flutter_secure_storage
- **API Keys**: Never hardcode API keys in source code

```dart
class SecureStorage {
  static const _storage = FlutterSecureStorage();
  
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
```

### 2. Data Validation
- **Input Validation**: Validate all user inputs
- **Type Safety**: Use strong typing
- **Sanitization**: Sanitize data before processing

## Code Quality Tools

### 1. Analysis Options
```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  
linter:
  rules:
    prefer_single_quotes: true
    require_trailing_commas: true
    sort_constructors_first: true
    always_use_package_imports: true
```


## Accessibility Guidelines

### 1. Semantic Markup
```dart
Semantics(
  label: 'Login button',
  hint: 'Double tap to log in',
  child: ElevatedButton(
    onPressed: _login,
    child: const Text('Login'),
  ),
)
```

### 2. Color Contrast
- **WCAG Guidelines**: Follow Web Content Accessibility Guidelines
- **Color Independence**: Don't rely solely on color for information

## Internationalization

### 1. Setup
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any
```

### 2. Implementation
```dart
// Generated localization
class S {
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }
  
  String get loginTitle => 'Login';
  String get emailLabel => 'Email';
  String get passwordLabel => 'Password';
}

// Usage in widgets
Text(S.of(context).loginTitle)
```

## Common Patterns to Follow

### 1. Repository Pattern
Always abstract data sources behind repository interfaces

### 2. Use Case Pattern
Encapsulate business logic in use cases

### 3. Observer Pattern
Use BLoC for reactive programming

### 4. Builder Pattern
Use for complex object creation

### 5. Factory Pattern
Use for object creation based on conditions

## Anti-Patterns to Avoid

### 1. Don't use setState in StatelessWidget
### 2. Avoid deep widget nesting
### 3. Don't put business logic in widgets
### 4. Avoid using print() for logging
### 5. Don't ignore async/await best practices

## Documentation Standards

### 1. Code Documentation
```dart
/// Authenticates a user with email and password.
/// 
/// Returns a [User] object if successful, throws [AuthException] if failed.
/// 
/// Example:
/// ```dart
/// final user = await authService.login('user@example.com', 'password');
/// ```
Future<User> login(String email, String password) async {
  // Implementation
}
```

### 2. README Structure
- Project description
- Installation instructions
- Usage examples
- API documentation
- Contributing guidelines

This guide ensures your Flutter development follows industry best practices for maintainable, scalable, and high-quality mobile applications.