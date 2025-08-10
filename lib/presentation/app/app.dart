import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/themes/app_theme.dart';
import 'package:savedge/features/auth/presentation/bloc/phone_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/widgets/profile_auth_wrapper.dart';

/// Main application widget
class SavedgeApp extends StatelessWidget {
  const SavedgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PhoneAuthCubit>(),
      child: MaterialApp(
        title: 'Savedge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const ProfileAuthWrapper(),
      ),
    );
  }
}
