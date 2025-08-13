# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Savedge is a Flutter mobile application that provides coupon management and vendor discovery services. The app uses Firebase for authentication and a custom backend API for business logic. It follows clean architecture principles with feature-based organization.

## Development Commands

### Building and Running
```bash
# Run the app in development mode
flutter run

# Build for Android release
flutter build apk --release

# Build for iOS release  
flutter build ios --release

# Run on specific device
flutter run -d <device_id>
```

### Code Generation
```bash
# Generate code for models, repositories, and dependency injection
flutter packages pub run build_runner build

# Watch for changes and auto-generate
flutter packages pub run build_runner watch

# Clean generated files and regenerate
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing and Quality
```bash
# Run all tests
flutter test

# Run analyzer (linting and static analysis)
flutter analyze

# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

## Architecture

### Clean Architecture Structure
The project follows Clean Architecture with three main layers:

1. **Domain Layer** (`lib/features/*/domain/`): Contains business entities, repositories interfaces, and use cases
2. **Data Layer** (`lib/features/*/data/`): Contains repository implementations, data sources, and data models
3. **Presentation Layer** (`lib/features/*/presentation/`): Contains UI widgets, pages, and BLoC state management

### Core Components
- **Dependency Injection**: Uses `get_it` and `injectable` for service locator pattern (configured in `lib/core/injection/injection.dart`)
- **State Management**: BLoC pattern with `flutter_bloc` for all state management
- **Network Layer**: Dio HTTP client with custom interceptors for authentication and logging
- **Code Generation**: Uses `freezed`, `json_serializable`, and `retrofit` for model generation and API clients

### Key Features
- **Authentication**: Firebase phone authentication with custom user sync to backend API
- **Vendors**: Browse and view vendor details with location-based services
- **Coupons**: View featured coupons and vendor-specific offers with redemption flow
- **Subscriptions**: Razorpay integration for subscription plan purchases
- **Profile Management**: User profile with statistics and settings

### Data Sources and APIs
- **Backend API**: Custom REST API at `https://192.168.1.36:44447` (configured in `AppConstants`)
- **Firebase**: Authentication and user management
- **Local Storage**: SharedPreferences for user data caching

### Code Style and Conventions
- Follows `flutter_lints` rules with additional custom lints in `analysis_options.yaml`
- Uses single quotes, trailing commas, and package imports
- Generated files (`.g.dart`, `.freezed.dart`) are excluded from analysis
- All features follow the same clean architecture pattern
- Use cases extend the base `UseCase<ReturnType, Params>` class with proper error handling
- Parameter classes extend `Equatable` for value comparison
- Failure messages are centralized in `FailureMessageMapper` utility class
- All public APIs have comprehensive documentation with `///` comments

### Key Directories
- `lib/core/`: Shared utilities, constants, themes, and dependency injection
- `lib/features/`: Feature modules organized by domain (app, auth, home, user_profile, qr_scanner, stores, vendors, coupons, subscription)
- `lib/shared/`: Common widgets and utilities used across features

### Refactored Architecture
The app has been completely refactored to follow Clean Architecture principles:

**Feature Structure:**
```
features/
├── app/                 # Main app navigation and core UI
├── auth/                # Authentication (Firebase phone auth)
├── home/                # Home page widgets and components
├── user_profile/        # User profile management
├── qr_scanner/          # QR code scanning functionality
├── stores/              # Store browsing and vendor details
├── vendors/             # Vendor management and listings
├── coupons/             # Coupon redemption and management
└── subscription/        # Subscription plans and payments
```

**Domain Layer Compliance:**
- All HTTP services moved from `domain/services/` to `data/services/`
- Domain layer contains only pure business logic (entities, repositories, use cases)
- Data layer handles all external communication (APIs, storage, services)

## Development Notes

### Code Generation Requirements
Run `flutter packages pub run build_runner build` after:
- Adding new `@freezed` classes
- Modifying `@JsonSerializable` models
- Adding new `@RestApi` interfaces
- Changing dependency injection annotations

### Firebase Setup
The project uses FlutterFire CLI configuration. Firebase options are auto-generated in `firebase_options.dart`.

### Testing Strategy
- Uses `bloc_test` for BLoC testing
- Uses `mocktail` for mocking dependencies
- Test files should be created in `test/` directory mirroring `lib/` structure