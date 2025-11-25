import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/core/network/jwt_token_interceptor.dart';
import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
// Auth imports
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
// New OTP Auth imports
import 'package:savedge/features/auth/data/datasources/otp_auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:savedge/features/auth/data/repositories/otp_auth_repository_impl.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';
import 'package:savedge/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/register_individual_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sync_user_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:savedge/features/auth/presentation/bloc/otp_auth_cubit.dart';
import 'package:savedge/features/brand_vouchers/data/repositories/brand_voucher_repository_impl.dart';
// Brand voucher imports
import 'package:savedge/features/brand_vouchers/data/services/brand_voucher_service.dart';
import 'package:savedge/features/brand_vouchers/domain/repositories/brand_voucher_repository.dart';
import 'package:savedge/features/brand_vouchers/domain/usecases/create_voucher_order_usecase.dart';
import 'package:savedge/features/brand_vouchers/domain/usecases/get_brand_vouchers_usecase.dart';
import 'package:savedge/features/brand_vouchers/domain/usecases/get_voucher_orders_usecase.dart';
import 'package:savedge/features/brand_vouchers/presentation/bloc/brand_vouchers_bloc.dart';
import 'package:savedge/features/coupons/data/services/coupon_payment_service.dart';
import 'package:savedge/features/coupons/data/services/coupon_service.dart';
// Enhanced coupon imports
import 'package:savedge/features/coupons/data/services/enhanced_coupon_service.dart';
import 'package:savedge/features/coupons/data/services/gifting_service.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/gifting_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_bloc.dart';
// Favorites imports
import 'package:savedge/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:savedge/features/favorites/data/models/favorite_vendor_adapter.dart';
import 'package:savedge/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:savedge/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:savedge/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:savedge/features/favorites/domain/usecases/check_favorite_usecase.dart';
import 'package:savedge/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:savedge/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_bloc.dart';
// Points payment imports
import 'package:savedge/features/points_payment/data/services/points_payment_service.dart';
import 'package:savedge/features/static_pages/data/services/contact_message_service.dart';
// Subscription imports
import 'package:savedge/features/subscription/data/datasources/subscription_plan_remote_data_source.dart';
import 'package:savedge/features/subscription/data/datasources/subscription_remote_data_source.dart';
import 'package:savedge/features/subscription/data/repositories/subscription_plan_repository_impl.dart';
import 'package:savedge/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:savedge/features/subscription/data/services/razorpay_payment_service.dart';
import 'package:savedge/features/subscription/data/services/razorpay_service.dart';
import 'package:savedge/features/subscription/domain/repositories/subscription_plan_repository.dart';
import 'package:savedge/features/subscription/domain/repositories/subscription_repository.dart';
import 'package:savedge/features/subscription/domain/usecases/subscription_usecases.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_plan_bloc.dart';
import 'package:savedge/features/user_profile/data/datasources/points_remote_data_source.dart';
import 'package:savedge/features/user_profile/data/repositories/points_repository_impl.dart';
import 'package:savedge/features/user_profile/domain/repositories/points_repository.dart';
import 'package:savedge/features/user_profile/domain/usecases/get_user_points_usecase.dart';
import 'package:savedge/features/user_profile/presentation/bloc/points_bloc.dart';
import 'package:savedge/features/vendors/data/datasources/coupons_remote_data_source.dart';
import 'package:savedge/features/vendors/data/datasources/vendors_remote_data_source.dart';
import 'package:savedge/features/vendors/data/repositories/coupons_repository_impl.dart';
import 'package:savedge/features/vendors/data/repositories/vendors_repository_impl.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';
import 'package:savedge/features/vendors/domain/usecases/get_featured_coupons_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_special_offer_coupons_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_coupons_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendors_usecase.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
// Free trial imports
import 'package:savedge/features/free_trial/data/repositories/free_trial_repository.dart';
import 'package:savedge/features/free_trial/presentation/bloc/free_trial_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Initialize Hive for Flutter
  await Hive.initFlutter();

  // Register Hive adapters (only register if not already registered)
  if (!Hive.isAdapterRegistered(10)) {
    Hive.registerAdapter(FavoriteVendorModelAdapter());
  }

  // Initialize favorites box
  await FavoritesLocalDataSourceImpl.initializeBox();

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Secure storage service
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());

  // Dio HTTP client
  getIt.registerSingleton<Dio>(_createDio());

  // HTTP client wrapper
  getIt.registerSingleton<HttpClient>(DioHttpClient(getIt<Dio>()));

  // Auth layer
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerSingleton<GetProfileUseCase>(
    GetProfileUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<SyncUserUseCase>(
    SyncUserUseCase(getIt<AuthRepository>()),
  );

  // New OTP Auth layer
  getIt.registerSingleton<OtpAuthRemoteDataSource>(
    OtpAuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerSingleton<OtpAuthRepository>(
    OtpAuthRepositoryImpl(getIt<OtpAuthRemoteDataSource>()),
  );
  getIt.registerSingleton<SendOtpUseCase>(
    SendOtpUseCase(getIt<OtpAuthRepository>()),
  );
  getIt.registerSingleton<VerifyOtpUseCase>(
    VerifyOtpUseCase(getIt<OtpAuthRepository>()),
  );
  getIt.registerSingleton<RegisterIndividualUseCase>(
    RegisterIndividualUseCase(getIt<OtpAuthRepository>()),
  );

  getIt.registerSingleton<VendorsRemoteDataSource>(
    VendorsRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerSingleton<CouponsRemoteDataSource>(
    CouponsRemoteDataSource(getIt<Dio>()),
  );

  // Points layer
  getIt.registerSingleton<PointsRemoteDataSource>(
    PointsRemoteDataSource(getIt<Dio>()),
  );

  // Subscription layer
  getIt.registerSingleton<SubscriptionPlanRemoteDataSource>(
    SubscriptionPlanRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerSingleton<SubscriptionRemoteDataSource>(
    SubscriptionRemoteDataSource(getIt<Dio>()),
  );

  // Brand voucher layer
  getIt.registerSingleton<BrandVoucherService>(
    BrandVoucherService(getIt<Dio>()),
  );

  // Repositories
  getIt.registerSingleton<VendorsRepository>(
    VendorsRepositoryImpl(remoteDataSource: getIt<VendorsRemoteDataSource>()),
  );

  getIt.registerSingleton<CouponsRepository>(
    CouponsRepositoryImpl(getIt<CouponsRemoteDataSource>()),
  );

  getIt.registerSingleton<PointsRepository>(
    PointsRepositoryImpl(remoteDataSource: getIt<PointsRemoteDataSource>()),
  );

  getIt.registerSingleton<SubscriptionPlanRepository>(
    SubscriptionPlanRepositoryImpl(getIt<SubscriptionPlanRemoteDataSource>()),
  );

  getIt.registerSingleton<SubscriptionRepository>(
    SubscriptionRepositoryImpl(
      remoteDataSource: getIt<SubscriptionRemoteDataSource>(),
    ),
  );

  getIt.registerSingleton<BrandVoucherRepository>(
    BrandVoucherRepositoryImpl(getIt<BrandVoucherService>()),
  );

  // Free trial layer
  getIt.registerSingleton<FreeTrialRepository>(
    FreeTrialRepositoryImpl(getIt<Dio>()),
  );

  // Favorites layer
  getIt.registerSingleton<FavoritesLocalDataSource>(
    FavoritesLocalDataSourceImpl(),
  );

  getIt.registerSingleton<FavoritesRepository>(
    FavoritesRepositoryImpl(localDataSource: getIt<FavoritesLocalDataSource>()),
  );

  // Favorites Use Cases
  getIt.registerSingleton<GetFavoritesUseCase>(
    GetFavoritesUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerSingleton<AddFavoriteUseCase>(
    AddFavoriteUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerSingleton<RemoveFavoriteUseCase>(
    RemoveFavoriteUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerSingleton<CheckFavoriteUseCase>(
    CheckFavoriteUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerSingleton<GetVendorsUseCase>(
    GetVendorsUseCase(getIt<VendorsRepository>()),
  );

  getIt.registerSingleton<GetVendorUseCase>(
    GetVendorUseCase(getIt<VendorsRepository>()),
  );

  getIt.registerSingleton<GetFeaturedCouponsUseCase>(
    GetFeaturedCouponsUseCase(getIt<CouponsRepository>()),
  );

  getIt.registerSingleton<GetVendorCouponsUseCase>(
    GetVendorCouponsUseCase(getIt<CouponsRepository>()),
  );

  getIt.registerSingleton<GetSpecialOfferCouponsUseCase>(
    GetSpecialOfferCouponsUseCase(getIt<CouponsRepository>()),
  );

  // Points Use Cases
  getIt.registerSingleton<GetUserPointsUseCase>(
    GetUserPointsUseCase(getIt<PointsRepository>()),
  );

  getIt.registerSingleton<GetPointsLedgerUseCase>(
    GetPointsLedgerUseCase(getIt<PointsRepository>()),
  );

  getIt.registerSingleton<AllocatePointsUseCase>(
    AllocatePointsUseCase(getIt<PointsRepository>()),
  );

  getIt.registerSingleton<GetPointsExpiringUseCase>(
    GetPointsExpiringUseCase(getIt<PointsRepository>()),
  );

  getIt.registerSingleton<GetExpiredPointsCountUseCase>(
    GetExpiredPointsCountUseCase(getIt<PointsRepository>()),
  );

  // Subscription Use Cases
  getIt.registerSingleton<GetSubscriptionPlansUseCase>(
    GetSubscriptionPlansUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<GetUserSubscriptionUseCase>(
    GetUserSubscriptionUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<PurchaseSubscriptionUseCase>(
    PurchaseSubscriptionUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<PurchaseSubscriptionWithPointsUseCase>(
    PurchaseSubscriptionWithPointsUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<CreatePaymentOrderUseCase>(
    CreatePaymentOrderUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<VerifyPaymentUseCase>(
    VerifyPaymentUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<GetPaymentHistoryUseCase>(
    GetPaymentHistoryUseCase(getIt<SubscriptionRepository>()),
  );

  getIt.registerSingleton<CancelSubscriptionUseCase>(
    CancelSubscriptionUseCase(getIt<SubscriptionRepository>()),
  );

  // Brand voucher Use Cases
  getIt.registerSingleton<GetBrandVouchersUseCase>(
    GetBrandVouchersUseCase(getIt<BrandVoucherRepository>()),
  );

  getIt.registerSingleton<CreateVoucherOrderUseCase>(
    CreateVoucherOrderUseCase(getIt<BrandVoucherRepository>()),
  );

  getIt.registerSingleton<GetVoucherOrdersUseCase>(
    GetVoucherOrdersUseCase(getIt<BrandVoucherRepository>()),
  );

  getIt.registerFactory<VendorsBloc>(
    () => VendorsBloc(getVendorsUseCase: getIt<GetVendorsUseCase>()),
  );

  getIt.registerFactory<VendorDetailBloc>(
    () => VendorDetailBloc(getVendorUseCase: getIt<GetVendorUseCase>()),
  );

  getIt.registerFactory<CouponsBloc>(
    () => CouponsBloc(
      getFeaturedCouponsUseCase: getIt<GetFeaturedCouponsUseCase>(),
      getVendorCouponsUseCase: getIt<GetVendorCouponsUseCase>(),
      getSpecialOfferCouponsUseCase: getIt<GetSpecialOfferCouponsUseCase>(),
    ),
  );

  getIt.registerLazySingleton<SubscriptionPlanBloc>(
    () => SubscriptionPlanBloc(
      subscriptionPlanRepository: getIt<SubscriptionPlanRepository>(),
    ),
  );

  // Coupon BLoCs
  getIt.registerFactory<UserCouponsBloc>(() => UserCouponsBloc());

  // Enhanced coupon BLoCs
  getIt.registerFactory<CouponManagerBloc>(
    () => CouponManagerBloc(getIt<EnhancedCouponService>()),
  );

  getIt.registerFactory<GiftingBloc>(
    () => GiftingBloc(getIt<GiftingService>()),
  );

  // Points BLoC
  getIt.registerFactory<PointsBloc>(
    () => PointsBloc(
      getUserPointsUseCase: getIt<GetUserPointsUseCase>(),
      getPointsLedgerUseCase: getIt<GetPointsLedgerUseCase>(),
      getPointsExpiringUseCase: getIt<GetPointsExpiringUseCase>(),
      getExpiredPointsCountUseCase: getIt<GetExpiredPointsCountUseCase>(),
    ),
  );

  // Subscription BLoC
  getIt.registerFactory<SubscriptionBloc>(
    () => SubscriptionBloc(
      getSubscriptionPlansUseCase: getIt<GetSubscriptionPlansUseCase>(),
      getUserSubscriptionUseCase: getIt<GetUserSubscriptionUseCase>(),
      purchaseSubscriptionUseCase: getIt<PurchaseSubscriptionUseCase>(),
      purchaseSubscriptionWithPointsUseCase:
          getIt<PurchaseSubscriptionWithPointsUseCase>(),
      createPaymentOrderUseCase: getIt<CreatePaymentOrderUseCase>(),
      verifyPaymentUseCase: getIt<VerifyPaymentUseCase>(),
      getPaymentHistoryUseCase: getIt<GetPaymentHistoryUseCase>(),
      cancelSubscriptionUseCase: getIt<CancelSubscriptionUseCase>(),
    ),
  );

  // Brand voucher BLoC
  getIt.registerFactory<BrandVouchersBloc>(
    () => BrandVouchersBloc(
      getBrandVouchersUseCase: getIt<GetBrandVouchersUseCase>(),
      createVoucherOrderUseCase: getIt<CreateVoucherOrderUseCase>(),
      getVoucherOrdersUseCase: getIt<GetVoucherOrdersUseCase>(),
      brandVoucherRepository: getIt<BrandVoucherRepository>(),
    ),
  );

  // Favorites BLoC
  getIt.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
      addFavoriteUseCase: getIt<AddFavoriteUseCase>(),
      removeFavoriteUseCase: getIt<RemoveFavoriteUseCase>(),
      checkFavoriteUseCase: getIt<CheckFavoriteUseCase>(),
    ),
  );

  // Free trial BLoC
  getIt.registerLazySingleton<FreeTrialBloc>(
    () => FreeTrialBloc(getIt<FreeTrialRepository>()),
  );

  // Payment services
  getIt.registerLazySingleton<RazorpayPaymentService>(
    () => RazorpayPaymentService(),
  );

  getIt.registerLazySingleton<RazorpayService>(() => RazorpayService());

  // Coupon services
  getIt.registerLazySingleton<CouponService>(() => CouponService());
  getIt.registerLazySingleton<CouponPaymentService>(
    () => CouponPaymentService(),
  );

  // Contact us services
  getIt.registerSingleton<ContactMessageService>(
    ContactMessageService(getIt<Dio>()),
  );

  // Enhanced coupon services
  getIt.registerSingleton<EnhancedCouponService>(
    EnhancedCouponService(getIt<Dio>()),
  );

  getIt.registerSingleton<GiftingService>(GiftingService(getIt<Dio>()));

  // Points payment service
  getIt.registerSingleton<PointsPaymentService>(
    PointsPaymentService(getIt<Dio>()),
  );

  // Auth cubits
  getIt.registerFactory<OtpAuthCubit>(
    () => OtpAuthCubit(
      getIt<SendOtpUseCase>(),
      getIt<VerifyOtpUseCase>(),
      getIt<RegisterIndividualUseCase>(),
    ),
  );
}

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Configure SSL certificate handling for development
  if (kDebugMode && !kIsWeb && Platform.isAndroid) {
    dio.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
  }

  // Add interceptors for logging, authentication, etc.
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
  }

  // JWT token interceptor for OTP-based authentication
  dio.interceptors.add(JwtTokenInterceptor());

  return dio;
}
