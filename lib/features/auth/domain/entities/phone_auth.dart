import 'package:equatable/equatable.dart';

/// Phone authentication entity
class PhoneAuth extends Equatable {
  const PhoneAuth({
    required this.phoneNumber,
    required this.countryCode,
    this.verificationId,
    this.resendToken,
  });

  final String phoneNumber;
  final String countryCode;
  final String? verificationId;
  final int? resendToken;

  /// Gets the complete phone number with country code
  String get completePhoneNumber => '$countryCode$phoneNumber';

  /// Gets the formatted phone number for display
  String get formattedPhoneNumber => '$countryCode $phoneNumber';

  PhoneAuth copyWith({
    String? phoneNumber,
    String? countryCode,
    String? verificationId,
    int? resendToken,
  }) {
    return PhoneAuth(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, countryCode, verificationId, resendToken];
}
