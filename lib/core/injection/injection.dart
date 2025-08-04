import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:savedge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/usecases/check_user_exists_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sync_user_profile_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/vendors/data/datasources/vendors_remote_data_source.dart';
import 'package:savedge/features/vendors/data/repositories/vendors_repository_impl.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendors_usecase.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Firebase Auth
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Dio HTTP client
  getIt.registerSingleton<Dio>(_createDio());

  // Data sources
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerSingleton<FirebaseAuthDataSource>(
    FirebaseAuthDataSourceImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerSingleton<VendorsRemoteDataSource>(
    VendorsRemoteDataSource(getIt<Dio>()),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
      getIt<FirebaseAuthDataSource>(),
    ),
  );

  getIt.registerSingleton<VendorsRepository>(
    VendorsRepositoryImpl(remoteDataSource: getIt<VendorsRemoteDataSource>()),
  );

  // Use cases
  getIt.registerSingleton<CheckUserExistsUseCase>(
    CheckUserExistsUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<RegisterUserUseCase>(
    RegisterUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<SendOtpUseCase>(
    SendOtpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<SignOutUseCase>(
    SignOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<SyncUserProfileUseCase>(
    SyncUserProfileUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<VerifyOtpUseCase>(
    VerifyOtpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerSingleton<GetVendorsUseCase>(
    GetVendorsUseCase(getIt<VendorsRepository>()),
  );

  // BLoCs (as factories since they should be created fresh each time)
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      sendOtpUseCase: getIt<SendOtpUseCase>(),
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      checkUserExistsUseCase: getIt<CheckUserExistsUseCase>(),
      registerUserUseCase: getIt<RegisterUserUseCase>(),
      syncUserProfileUseCase: getIt<SyncUserProfileUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
    ),
  );

  getIt.registerFactory<VendorsBloc>(
    () => VendorsBloc(getVendorsUseCase: getIt<GetVendorsUseCase>()),
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
    dio.httpClientAdapter = DefaultHttpClientAdapter()
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

  // Add authentication interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add Firebase ID token to requests if user is authenticated
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final token = await user.getIdToken();
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          // Handle token retrieval errors silently
          if (kDebugMode) {
            print('Token retrieval error: $e');
          }
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle common HTTP errors
        if (error.response?.statusCode == 401) {
          // Handle unauthorized access
          if (kDebugMode) {
            print('Unauthorized access detected');
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
}
