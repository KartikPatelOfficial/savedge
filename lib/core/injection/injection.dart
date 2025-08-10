import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/vendors/data/datasources/vendors_remote_data_source.dart';
import 'package:savedge/features/vendors/data/datasources/coupons_remote_data_source.dart';
import 'package:savedge/features/vendors/data/repositories/vendors_repository_impl.dart';
import 'package:savedge/features/vendors/data/repositories/coupons_repository_impl.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendors_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_featured_coupons_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_coupons_usecase.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Auth imports
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sync_user_usecase.dart';
import 'package:savedge/features/auth/presentation/bloc/phone_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_status_cubit.dart';
import 'package:savedge/core/network/auth_token_interceptor.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Firebase Auth
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Dio HTTP client
  getIt.registerSingleton<Dio>(_createDio());

  // Auth layer
  getIt.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSource(getIt<Dio>()));
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt<AuthRemoteDataSource>()));
  getIt.registerSingleton<GetProfileUseCase>(GetProfileUseCase(getIt<AuthRepository>()));
  getIt.registerSingleton<SyncUserUseCase>(SyncUserUseCase(getIt<AuthRepository>()));

  getIt.registerSingleton<VendorsRemoteDataSource>(
    VendorsRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerSingleton<CouponsRemoteDataSource>(
    CouponsRemoteDataSource(getIt<Dio>()),
  );

  // Repositories
  getIt.registerSingleton<VendorsRepository>(
    VendorsRepositoryImpl(remoteDataSource: getIt<VendorsRemoteDataSource>()),
  );

  getIt.registerSingleton<CouponsRepository>(
    CouponsRepositoryImpl(getIt<CouponsRemoteDataSource>()),
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

  getIt.registerFactory<VendorsBloc>(
    () => VendorsBloc(getVendorsUseCase: getIt<GetVendorsUseCase>()),
  );

  getIt.registerFactory<VendorDetailBloc>(
    () => VendorDetailBloc(getVendorUseCase: getIt<GetVendorUseCase>()),
  );

  getIt.registerFactory<CouponsBloc>(() => CouponsBloc(
        getFeaturedCouponsUseCase: getIt<GetFeaturedCouponsUseCase>(),
        getVendorCouponsUseCase: getIt<GetVendorCouponsUseCase>(),
      ));

  // Auth cubits
  getIt.registerFactory<PhoneAuthCubit>(() => PhoneAuthCubit(getIt<FirebaseAuth>()));
  getIt.registerFactory<AuthStatusCubit>(() => AuthStatusCubit(
        firebaseAuth: getIt<FirebaseAuth>(),
        syncUserUseCase: getIt<SyncUserUseCase>(),
      ));
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

  // Auth token interceptor
  dio.interceptors.add(AuthTokenInterceptor(FirebaseAuth.instance));

  return dio;
}
