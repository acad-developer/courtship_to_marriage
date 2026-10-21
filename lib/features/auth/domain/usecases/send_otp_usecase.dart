import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository _repository;
  SendOtpUseCase(this._repository);

  Future<void> call({
    required String phoneNumber,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String uid) onAutoVerified,
    required void Function(String message) onFailed,
  }) =>
      _repository.sendOtp(
        phoneNumber: phoneNumber,
        resendToken: resendToken,
        onCodeSent: onCodeSent,
        onAutoVerified: onAutoVerified,
        onFailed: onFailed,
      );
}