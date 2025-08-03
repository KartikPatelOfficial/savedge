import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();

/// Register external dependencies that cannot be registered with @injectable
@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  Dio get dio {
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
      // For Android, you might need to add a custom certificate handler
      dio.httpClientAdapter = DefaultHttpClientAdapter()
        ..onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
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
            // You might want to trigger a logout here
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

  @lazySingleton
  AuthRemoteDataSource authRemoteDataSource(Dio dio) {
    return AuthRemoteDataSource(dio);
  }
}
