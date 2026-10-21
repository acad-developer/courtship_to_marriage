import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/app_exception.dart';

abstract class AuthRemoteDataSource {
  User? get currentUser;

  Future<void> sendOtp({
    required String phoneNumber,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String uid) onAutoVerified,
    required void Function(String message) onFailed,
  });

  Future<String> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  AuthRemoteDataSourceImpl(this._auth);

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    int? resendToken,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String uid) onAutoVerified,
    required void Function(String message) onFailed,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: resendToken,
        verificationCompleted: (credential) async {
          try {
            final result = await _auth.signInWithCredential(credential);
            if (result.user != null) onAutoVerified(result.user!.uid);
          } on FirebaseAuthException catch (e) {
            onFailed(_message(e));
          }
        },
        verificationFailed: (e) => onFailed(_message(e)),
        codeSent: (verificationId, token) => onCodeSent(verificationId, token),
        codeAutoRetrievalTimeout: (_) {},
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(_message(e));
    }
  }

  @override
  Future<String> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) throw const AppException('Sign in failed. Try again.');
      return user.uid;
    } on FirebaseAuthException catch (e) {
      throw AppException(_message(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AppException(_message(e));
    }
  }

  String _message(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'The phone number is not valid.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'invalid-verification-code':
        return 'Incorrect OTP. Please check and try again.';
      case 'session-expired':
      case 'code-expired':
        return 'The OTP has expired. Please request a new one.';
      case 'network-request-failed':
        return 'No internet connection. Please try again.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}