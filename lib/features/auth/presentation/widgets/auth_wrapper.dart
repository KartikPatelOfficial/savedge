import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/auth/presentation/pages/phone_input_page.dart';
import 'package:savedge/presentation/home/pages/home_page.dart';

/// Wrapper widget that handles authentication flow on app start
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const CheckAuthStatusEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return _buildPageForState(state);
        },
      ),
    );
  }

  Widget _buildPageForState(AuthState state) {
    switch (state.runtimeType) {
      case AuthInitial:
      case AuthStatusChecking:
        return const _LoadingPage();

      case AuthUserExists:
        // User is authenticated and exists in database - go to home
        return const HomePage();

      case AuthUnauthenticated:
      case AuthSignedOut:
        // User needs to login
        return const PhoneInputPage();

      case AuthError:
        final errorState = state as AuthError;
        return _ErrorPage(message: errorState.message);

      default:
        // For any other state, show login page
        return const PhoneInputPage();
    }
  }
}

/// Loading page shown during authentication check
class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Checking authentication...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// Error page shown when authentication check fails
class _ErrorPage extends StatelessWidget {
  const _ErrorPage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            Text(
              'Authentication Error',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Restart authentication check
                context.read<AuthBloc>().add(const CheckAuthStatusEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
