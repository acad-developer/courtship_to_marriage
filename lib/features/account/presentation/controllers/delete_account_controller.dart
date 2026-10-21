import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../../auth/domain/usecases/send_otp_usecase.dart';
import '../../../auth/domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';

enum DeleteStep { warning, verify }

class DeleteAccountController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final SendOtpUseCase _sendOtp;
  final VerifyOtpUseCase _verifyOtp;
  final DeleteAccountUseCase _deleteAccount;

  DeleteAccountController(
      this._getCurrentAuthUser,
      this._sendOtp,
      this._verifyOtp,
      this._deleteAccount,
      );

  static const confirmWord = 'DELETE';

  final confirmController = TextEditingController();
  final otpController = TextEditingController();

  final step = DeleteStep.warning.obs;
  final canContinue = false.obs;
  final isSending = false.obs;
  final isDeleting = false.obs;
  final secondsLeft = 0.obs;

  AuthUser? _user;
  String _verificationId = '';
  int? _resendToken;
  Timer? _timer;

  bool get isBusy => isSending.value || isDeleting.value;
  bool get canResend => secondsLeft.value == 0 && !isBusy;

  String get phone => _user?.phoneNumber ?? '';

  String get maskedPhone {
    final p = phone;
    if (p.length < 8) return p;
    return '${p.substring(0, 3)}${'•' * (p.length - 7)}${p.substring(p.length - 4)}';
  }

  String get timerText {
    final m = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void onInit() {
    super.onInit();
    _user = _getCurrentAuthUser();
    confirmController.addListener(() {
      canContinue.value = confirmController.text.trim() == confirmWord;
    });
  }

  /// Step 1 -> sends the OTP to the user's own number.
  Future<void> sendCode() async {
    if (isBusy || !canContinue.value) return;
    final user = _user;
    if (user == null || user.phoneNumber!.isEmpty) {
      AppSnackbar.error('Please sign in again.');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    isSending.value = true;
    try {
      await _sendOtp(
        phoneNumber: user.phoneNumber!,
        resendToken: _resendToken,
        onCodeSent: (verificationId, token) {
          _verificationId = verificationId;
          _resendToken = token;
          isSending.value = false;
          otpController.clear();
          step.value = DeleteStep.verify;
          _startTimer();
        },
        // Android can verify the SMS automatically.
        onAutoVerified: (uid) => _delete(uid),
        onFailed: (message) {
          isSending.value = false;
          AppSnackbar.error(message);
        },
      );
    } on AppException catch (e) {
      isSending.value = false;
      AppSnackbar.error(e.message);
    }
  }

  /// Step 2 -> checks the OTP, then deletes everything.
  Future<void> verifyAndDelete() async {
    if (isBusy) return;
    final code = otpController.text.trim();
    if (code.length != AppConstants.otpLength) {
      AppSnackbar.error('Please enter the 6-digit code.');
      return;
    }
    isDeleting.value = true;
    try {
      final uid =
      await _verifyOtp(verificationId: _verificationId, smsCode: code);
      await _delete(uid);
    } on AppException catch (e) {
      otpController.clear();
      isDeleting.value = false;
      AppSnackbar.error(e.message);
    }
  }

  Future<void> _delete(String uid) async {
    if (uid != _user?.uid) {
      isDeleting.value = false;
      AppSnackbar.error('That is a different phone number. Please try again.');
      return;
    }
    isDeleting.value = true;
    try {
      await _deleteAccount(uid);
      Get.offAllNamed(AppRoutes.login);
      AppSnackbar.success('Your account has been deleted.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      if (!isClosed) isDeleting.value = false;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    secondsLeft.value = AppConstants.otpResendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        t.cancel();
      }
    });
  }

  Future<void> resend() async {
    if (!canResend) return;
    isSending.value = true;
    try {
      await _sendOtp(
        phoneNumber: phone,
        resendToken: _resendToken,
        onCodeSent: (verificationId, token) {
          _verificationId = verificationId;
          _resendToken = token;
          isSending.value = false;
          otpController.clear();
          _startTimer();
          AppSnackbar.success('A new OTP has been sent.');
        },
        onAutoVerified: (uid) => _delete(uid),
        onFailed: (message) {
          isSending.value = false;
          AppSnackbar.error(message);
        },
      );
    } on AppException catch (e) {
      isSending.value = false;
      AppSnackbar.error(e.message);
    }
  }

  /// Back arrow: from the OTP step go back to the warning step.
  void goBack() {
    if (isDeleting.value) return;
    if (step.value == DeleteStep.verify) {
      step.value = DeleteStep.warning;
      return;
    }
    Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel();
    confirmController.dispose();
    otpController.dispose();
    super.onClose();
  }
}