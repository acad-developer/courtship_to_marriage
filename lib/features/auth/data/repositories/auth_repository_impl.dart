import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  AuthRepositoryImpl(this._remote);

  @override
  AuthUser? get currentUser {
    final user = _remote.currentUser;
    if (user == null) return null;
    return AuthUser(uid: user.uid, phoneNumber: user.phoneNumber);
  }

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String uid) onAutoVerified,
    required void Function(String message) onFailed,
  }) =>
      _remote.sendOtp(
        phoneNumber: phoneNumber,
        resendToken: resendToken,
        onCodeSent: onCodeSent,
        onAutoVerified: onAutoVerified,
        onFailed: onFailed,
      );

  @override
  Future<String> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) =>
      _remote.verifyOtp(verificationId: verificationId, smsCode: smsCode);

  @override
  Future<void> signOut() => _remote.signOut();
}