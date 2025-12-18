import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/themes/app_theme.dart';
import 'package:savedge/features/auth/presentation/bloc/otp_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:savedge/features/app/presentation/navigation/main_navigation_page.dart';
import 'package:savedge/features/brand_vouchers/presentation/pages/voucher_purchase_page.dart';
import 'package:savedge/features/brand_vouchers/presentation/pages/voucher_orders_page.dart';
import 'package:savedge/features/brand_vouchers/domain/entities/brand_voucher_entity.dart';
import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:savedge/features/notifications/presentation/pages/notification_center_page.dart';

/// Main application widget
class SavedgeApp extends StatelessWidget {
  const SavedgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OtpAuthCubit>()),
        BlocProvider(create: (context) => getIt<NotificationBloc>()),
        BlocProvider(
          create: (context) =>
              getIt<CityBloc>()..add(const LoadSavedCitySelection()),
        ),
      ],
      child: MaterialApp(
        title: 'Savedge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: const AuthWrapper(),
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const MainNavigationPage(),
        );
      case '/voucher-purchase':
        final voucher = settings.arguments as BrandVoucherEntity;
        return MaterialPageRoute(
          builder: (_) => VoucherPurchasePage(voucher: voucher),
          settings: settings,
        );
      case '/voucher-orders':
        return MaterialPageRoute(
          builder: (_) => const VoucherOrdersPage(),
          settings: settings,
        );
      case '/notifications':
        return MaterialPageRoute(
          builder: (_) => const NotificationCenterPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
