import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;
  VerifyOtpUseCase(this._repository);

  Future<String> call({
    required String verificationId,
    required String smsCode,
  }) =>
      _repository.verifyOtp(verificationId: verificationId, smsCode: smsCode);
}