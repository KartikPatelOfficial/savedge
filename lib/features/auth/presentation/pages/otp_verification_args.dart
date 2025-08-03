/// Arguments passed to OTP verification page
class OtpVerificationArgs {
  const OtpVerificationArgs({
    required this.phoneNumber,
    required this.countryCode,
    required this.verificationId,
  });

  final String phoneNumber;
  final String countryCode;
  final String verificationId;
}
