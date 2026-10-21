class OtpArguments {
  final String phoneNumber; // E.164, e.g. +919876543210
  final String verificationId;
  final int? resendToken;

  const OtpArguments({
    required this.phoneNumber,
    required this.verificationId,
    this.resendToken,
  });
}