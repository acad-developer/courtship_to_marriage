import '../entities/auth_user.dart';

abstract class AuthRepository {
  AuthUser? get currentUser;

  Future<void> sendOtp({
    required String phoneNumber,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String uid) onAutoVerified,
    required void Function(String message) onFailed,
  });

  /// Returns the signed-in user's uid.
  Future<String> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<void> signOut();
}