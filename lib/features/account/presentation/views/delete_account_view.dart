import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/page_header.dart';
import '../controllers/delete_account_controller.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) controller.goBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            AppPageHeader(title: 'Delete Account', onBack: controller.goBack),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: Obx(() => controller.step.value == DeleteStep.warning
                    ? _WarningStep(controller: controller)
                    : _VerifyStep(controller: controller)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DangerButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onPressed;
  const _DangerButton(
      {required this.label, required this.loading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          disabledBackgroundColor: AppColors.error.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: loading
            ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                strokeWidth: 2.4, color: Colors.white))
            : Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w700, letterSpacing: 1.2)),
      ),
    );
  }
}

class _WarningStep extends StatelessWidget {
  final DeleteAccountController controller;
  const _WarningStep({required this.controller});

  static const _items = [
    'Your profile (name, email and phone number)',
    'Your purchased courses and access to all their lessons',
    'Your messages to our support team',
    'Your sign-in. You will need to register again to use the app.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: AppColors.error, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('This cannot be undone',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.error)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Deleting your account permanently removes:',
                style: TextStyle(height: 1.5, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              for (final i in _items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Icon(Icons.circle,
                            size: 6, color: AppColors.error),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(i,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: AppColors.textSecondary))),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              const Text(
                'Courses you have paid for are not refunded and cannot be '
                    'restored after deletion.',
                style: TextStyle(height: 1.5, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text('Type DELETE to confirm', style: AppTextStyles.heading(20)),
        const SizedBox(height: 12),
        TextField(
          controller: controller.confirmController,
          textCapitalization: TextCapitalization.characters,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: DeleteAccountController.confirmWord,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Next we'll send a code to ${controller.maskedPhone} to confirm "
              "it's really you.",
          style: const TextStyle(
              fontSize: 13, height: 1.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),
        Obx(() => _DangerButton(
          label: 'CONTINUE',
          loading: controller.isSending.value,
          onPressed:
          controller.canContinue.value ? controller.sendCode : null,
        )),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: Get.back,
            child: const Text('Keep my account',
                style: TextStyle(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

class _VerifyStep extends StatelessWidget {
  final DeleteAccountController controller;
  const _VerifyStep({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = PinTheme(
      width: 48,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Verify it\'s you', style: AppTextStyles.heading(26)),
        const SizedBox(height: 12),
        const Text('Enter the 6-digit code we sent to',
            style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(controller.maskedPhone,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 28),
        Center(
          child: Pinput(
            length: AppConstants.otpLength,
            controller: controller.otpController,
            autofocus: true,
            keyboardType: TextInputType.number,
            defaultPinTheme: theme,
            focusedPinTheme: theme.copyWith(
              decoration: theme.decoration!.copyWith(
                border: Border.all(color: AppColors.error, width: 1.5),
              ),
            ),
            onCompleted: (_) => controller.verifyAndDelete(),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Obx(() => controller.canResend
              ? TextButton(
            onPressed: controller.resend,
            child: const Text('Resend Code',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          )
              : Text('Resend code in ${controller.timerText}',
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary))),
        ),
        const SizedBox(height: 24),
        Obx(() => _DangerButton(
          label: 'DELETE MY ACCOUNT',
          loading: controller.isDeleting.value,
          onPressed: controller.verifyAndDelete,
        )),
      ],
    );
  }
}