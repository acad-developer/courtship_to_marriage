import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../domain/usecases/get_post_auth_destination_usecase.dart';
import '../post_auth_navigation.dart';
import 'otp_arguments.dart';

class OtpController extends GetxController {
  final SendOtpUseCase _sendOtp;
  final VerifyOtpUseCase _verifyOtp;
  final GetPostAuthDestinationUseCase _getPostAuthDestination;

  OtpController(this._sendOtp, this._verifyOtp, this._getPostAuthDestination);

  final otpController = TextEditingController();
  final isVerifying = false.obs;
  final isResending = false.obs;
  final secondsLeft = AppConstants.otpResendSeconds.obs;

  late final OtpArguments args = Get.arguments as OtpArguments;
  late String _verificationId = args.verificationId;
  int? _resendToken;
  Timer? _timer;
  bool _navigated = false;

  bool get canResend => secondsLeft.value == 0 && !isResending.value;

  String get timerText {
    final m = (secondsLeft.value ~/ 60).toString().padLeft(2, '0');
    final s = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get maskedPhone {
    final p = args.phoneNumber;
    if (p.length < 8) return p;
    final hidden = '•' * (p.length - 7);
    return '${p.substring(0, 3)}$hidden${p.substring(p.length - 4)}';
  }

  @override
  void onInit() {
    super.onInit();
    _resendToken = args.resendToken;
    _startTimer();
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

  Future<void> verify() async {
    if (isVerifying.value) return;
    final code = otpController.text.trim();
    if (code.length != AppConstants.otpLength) {
      AppSnackbar.error('Please enter the 6-digit code.');
      return;
    }

    isVerifying.value = true;
    try {
      final uid = await _verifyOtp(verificationId: _verificationId, smsCode: code);
      await _goNext(uid);
    } on AppException catch (e) {
      otpController.clear();
      AppSnackbar.error(e.message);
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resend() async {
    if (!canResend) return;
    isResending.value = true;
    try {
      await _sendOtp(
        phoneNumber: args.phoneNumber,
        resendToken: _resendToken,
        onCodeSent: (verificationId, token) {
          _verificationId = verificationId;
          _resendToken = token;
          isResending.value = false;
          otpController.clear();
          _startTimer();
          AppSnackbar.success('A new OTP has been sent.');
        },
        onAutoVerified: _goNext,
        onFailed: (message) {
          isResending.value = false;
          AppSnackbar.error(message);
        },
      );
    } on AppException catch (e) {
      isResending.value = false;
      AppSnackbar.error(e.message);
    }
  }

  Future<void> _goNext(String uid) async {
    if (_navigated) return;
    _navigated = true;
    try {
      final destination = await _getPostAuthDestination(uid);
      Get.offAllNamed(destination.route);
    } on AppException catch (e) {
      _navigated = false;
      AppSnackbar.error(e.message);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}