import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/notifications/domain/repositories/notification_repository.dart';

/// Use case to register a device token for push notifications
class RegisterDeviceTokenUseCase implements UseCase<void, RegisterDeviceTokenParams> {
  final NotificationRepository repository;

  RegisterDeviceTokenUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterDeviceTokenParams params) {
    return repository.registerDeviceToken(
      token: params.token,
      platform: params.platform,
      deviceId: params.deviceId,
      deviceName: params.deviceName,
      appVersion: params.appVersion,
    );
  }
}

/// Parameters for registering a device token
class RegisterDeviceTokenParams extends Equatable {
  final String token;
  final int platform; // iOS = 0, Android = 1, Web = 2
  final String? deviceId;
  final String? deviceName;
  final String? appVersion;

  const RegisterDeviceTokenParams({
    required this.token,
    required this.platform,
    this.deviceId,
    this.deviceName,
    this.appVersion,
  });

  @override
  List<Object?> get props => [token, platform, deviceId, deviceName, appVersion];
}
