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
import 'package:savedge/features/gift_cards/presentation/pages/gift_cards_page.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_card_detail_page.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_card_checkout_page.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_card_orders_page.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_card_view_page.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:savedge/features/invoices/presentation/pages/invoices_page.dart';
import 'package:savedge/features/notifications/presentation/pages/notification_center_page.dart';
import 'package:savedge/core/widgets/animated_blur_background.dart';

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
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const AnimatedBlurBackground(),
              if (child != null)
                Theme(
                  data: Theme.of(context).copyWith(
                    scaffoldBackgroundColor: Colors.transparent,
                  ),
                  child: child,
                ),
            ],
          );
        },
      ),
    );
  }

  static Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        final initialTab = settings.arguments is int ? settings.arguments as int : 0;
        return MaterialPageRoute(
          builder: (_) => MainNavigationPage(initialTab: initialTab),
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
      case '/invoices':
        return MaterialPageRoute(
          builder: (_) => const InvoicesPage(),
          settings: settings,
        );
      case '/gift-cards':
        return MaterialPageRoute(
          builder: (_) => const GiftCardsPage(),
          settings: settings,
        );
      case '/gift-card-detail':
        final product = settings.arguments as GiftCardProductEntity;
        return MaterialPageRoute(
          builder: (_) => GiftCardDetailPage(product: product),
          settings: settings,
        );
      case '/gift-card-checkout':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => GiftCardCheckoutPage(
            product: args['product'] as GiftCardProductEntity,
            amount: args['amount'] as double,
            themeSku: args['themeSku'] as String?,
          ),
          settings: settings,
        );
      case '/gift-card-orders':
        return MaterialPageRoute(
          builder: (_) => const GiftCardOrdersPage(),
          settings: settings,
        );
      case '/gift-card-view':
        final order = settings.arguments as GiftCardOrderEntity;
        return MaterialPageRoute(
          builder: (_) => GiftCardViewPage(order: order),
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
