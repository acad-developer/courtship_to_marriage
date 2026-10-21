import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../otp/otp_arguments.dart';
import '../../domain/usecases/get_post_auth_destination_usecase.dart';
import '../post_auth_navigation.dart';

class LoginController extends GetxController {
  final SendOtpUseCase _sendOtp;
  final GetPostAuthDestinationUseCase _getPostAuthDestination;

  LoginController(this._sendOtp, this._getPostAuthDestination);

  final phoneController = TextEditingController();
  final dialCode = AppConstants.defaultDialCode.obs;
  final phoneError = RxnString();
  final isLoading = false.obs;

  bool _navigated = false;

  void onCountryChanged(CountryCode country) {
    dialCode.value = country.dialCode ?? AppConstants.defaultDialCode;
    phoneError.value = null;
  }

  Future<void> sendOtp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final error = Validators.phone(phoneController.text, dialCode.value);
    phoneError.value = error;
    if (error != null) return;

    final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');
    final fullNumber = '${dialCode.value}$digits';

    isLoading.value = true;
    try {
      await _sendOtp(
        phoneNumber: fullNumber,
        onCodeSent: (verificationId, resendToken) {
          isLoading.value = false;
          Get.toNamed(
            AppRoutes.otp,
            arguments: OtpArguments(
              phoneNumber: fullNumber,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        onAutoVerified: _goNext, // instant verification on some Android devices
        onFailed: (message) {
          isLoading.value = false;
          AppSnackbar.error(message);
        },
      );
    } on AppException catch (e) {
      isLoading.value = false;
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
      isLoading.value = false;
      AppSnackbar.error(e.message);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}