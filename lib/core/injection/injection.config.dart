// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/firebase_auth_data_source.dart'
    as _i492;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_user_exists_usecase.dart'
    as _i311;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/register_user_usecase.dart'
    as _i241;
import '../../features/auth/domain/usecases/send_otp_usecase.dart' as _i663;
import '../../features/auth/domain/usecases/sign_out_usecase.dart' as _i915;
import '../../features/auth/domain/usecases/sync_user_profile_usecase.dart'
    as _i773;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../network/network_client.dart' as _i30;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i30.HttpClient>(
      () => _i30.DioHttpClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => registerModule.authRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i492.FirebaseAuthDataSource>(
      () => _i492.FirebaseAuthDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i852.AuthLocalDataSource>(
      () => _i852.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i107.AuthRemoteDataSource>(),
        gh<_i852.AuthLocalDataSource>(),
        gh<_i492.FirebaseAuthDataSource>(),
      ),
    );
    gh.factory<_i311.CheckUserExistsUseCase>(
      () => _i311.CheckUserExistsUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i241.RegisterUserUseCase>(
      () => _i241.RegisterUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i663.SendOtpUseCase>(
      () => _i663.SendOtpUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i915.SignOutUseCase>(
      () => _i915.SignOutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i773.SyncUserProfileUseCase>(
      () => _i773.SyncUserProfileUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i503.VerifyOtpUseCase>(
      () => _i503.VerifyOtpUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i17.GetCurrentUserUseCase>(
      () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i797.AuthBloc>(
      () => _i797.AuthBloc(
        gh<_i663.SendOtpUseCase>(),
        gh<_i503.VerifyOtpUseCase>(),
        gh<_i311.CheckUserExistsUseCase>(),
        gh<_i241.RegisterUserUseCase>(),
        gh<_i773.SyncUserProfileUseCase>(),
        gh<_i17.GetCurrentUserUseCase>(),
        gh<_i915.SignOutUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
