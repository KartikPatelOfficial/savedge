import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/app/presentation/pages/app.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure HTTP client for network images in debug mode
  if (kDebugMode) {
    HttpOverrides.global = DevHttpOverrides();
  }

  try {
    // Configure dependencies
    await configureDependencies();

    // Verify critical dependencies are registered
    if (kDebugMode) {
      _verifyDependencies();
    }

    // Set up global BLoC observer for debugging
    Bloc.observer = AppBlocObserver();

    // Run the main app with new OTP-based auth system
    runApp(const SavedgeApp());
  } catch (e, stackTrace) {
    debugPrint('Error during app initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    // You might want to show an error screen here
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Failed to initialize app: $e')),
        ),
      ),
    );
  }
}

/// Verify that critical dependencies are properly registered
void _verifyDependencies() {
  try {
    final vendorsBloc = getIt<VendorsBloc>();
    debugPrint(
      '✓ VendorsBloc successfully registered: ${vendorsBloc.runtimeType}',
    );
  } catch (e) {
    debugPrint('✗ VendorsBloc registration failed: $e');
  }
}

/// Custom HTTP overrides for development to bypass SSL certificate validation
class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// Global BLoC observer for debugging and logging
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- ${bloc.runtimeType}');
  }
}
