import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/themes/app_theme.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/auth/presentation/pages/phone_input_page.dart';
import 'package:savedge/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:savedge/features/auth/presentation/pages/otp_verification_args.dart';
import 'package:savedge/features/auth/presentation/pages/user_setup_page.dart';
import 'package:savedge/features/auth/presentation/pages/organization_change_page.dart';
import 'package:savedge/presentation/home/pages/home_page.dart';
import 'package:savedge/presentation/app/auth_wrapper.dart';

/// Main application widget
class SavedgeApp extends StatelessWidget {
  const SavedgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        title: 'Savedge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/phone-input': (context) => const PhoneInputPage(),
          '/user-setup': (context) => const UserSetupPage(),
          '/home': (context) => const HomePage(),
          '/organization-change': (context) => const OrganizationChangePage(),
        },
        onGenerateRoute: (settings) {
          print('Generating route for: ${settings.name} with args: ${settings.arguments}');
          switch (settings.name) {
            case '/otp-verification':
              final args = settings.arguments as OtpVerificationArgs?;
              if (args != null) {
                print('Creating OTP verification page with args: ${args.phoneNumber}');
                return MaterialPageRoute(
                  builder: (context) => const OtpVerificationPage(),
                  settings: settings,
                );
              }
              break;
          }
          return null;
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const PhoneInputPage(),
          );
        },
      ),
    );
  }
}
