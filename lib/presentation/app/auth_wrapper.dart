import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/auth/presentation/pages/phone_input_page.dart';
import 'package:savedge/presentation/home/pages/home_page.dart';

/// Wrapper widget that handles authentication state and navigation
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Check authentication status when the app starts
    print('AuthWrapper: Checking authentication status on app start');
    context.read<AuthBloc>().add(const CheckAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('AuthWrapper: State changed to ${state.runtimeType}');
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        print('AuthWrapper: Building UI for state ${state.runtimeType}');
        
        // Show loading spinner while checking auth status on app start
        if (state is AuthStatusChecking) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Checking authentication...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        // User exists and is authenticated - show home page directly
        if (state is AuthUserExists) {
          print('AuthWrapper: User exists, showing home page');
          return const HomePage();
        }

        // For all other states (including navigation states), show phone input
        // The PhoneInputPage will handle its own navigation logic
        print('AuthWrapper: Showing phone input page');
        return const PhoneInputPage();
      },
    );
  }
}
