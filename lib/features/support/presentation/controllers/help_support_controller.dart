// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/errors/app_exception.dart';
// import '../../../../core/utils/app_snackbar.dart';
// import '../../../../core/utils/contact_actions.dart';
// import '../../../auth/domain/entities/auth_user.dart';
// import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
// import '../../../auth/domain/usecases/get_user_profile_usecase.dart';
// import '../../domain/entities/support_query.dart';
// import '../../domain/usecases/support_usecases.dart';
// import '../widgets/message_sent_dialog.dart';
//
// class HelpSupportController extends GetxController {
//   final GetCurrentAuthUserUseCase _getCurrentAuthUser;
//   final GetUserProfileUseCase _getUserProfile;
//   final SubmitSupportQueryUseCase _submitQuery;
//
//   HelpSupportController(
//       this._getCurrentAuthUser,
//       this._getUserProfile,
//       this._submitQuery,
//       );
//
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final subjectController = TextEditingController();
//   final messageController = TextEditingController();
//   final isSubmitting = false.obs;
//
//   AuthUser? _authUser;
//   String _phone = '';
//
//   @override
//   void onInit() {
//     super.onInit();
//     _authUser = _getCurrentAuthUser();
//     _phone = _authUser?.phoneNumber ?? '';
//     _prefill();
//   }
//
//   /// Fills name and email from the user's profile (the user can still edit them).
//   Future<void> _prefill() async {
//     final user = _authUser;
//     if (user == null) return;
//     try {
//       final profile = await _getUserProfile(user.uid);
//       if (profile == null) return;
//       if (nameController.text.isEmpty) nameController.text = profile.name;
//       if (emailController.text.isEmpty) emailController.text = profile.email;
//       if (profile.phoneNumber.isNotEmpty) _phone = profile.phoneNumber;
//     } catch (_) {
//       // The form still works without prefilled values.
//     }
//   }
//
//   Future<void> submit() async {
//     if (isSubmitting.value) return;
//
//     final user = _authUser;
//     if (user == null) {
//       AppSnackbar.error('Please sign in again.');
//       return;
//     }
//     if (!formKey.currentState!.validate()) return;
//
//     FocusManager.instance.primaryFocus?.unfocus();
//     isSubmitting.value = true;
//     try {
//       await _submitQuery(SupportQuery(
//         id: '',
//         uid: user.uid,
//         name: nameController.text.trim(),
//         email: emailController.text.trim().toLowerCase(),
//         phone: _phone,
//         subject: subjectController.text.trim(),
//         message: messageController.text.trim(),
//       ));
//       subjectController.clear();
//       messageController.clear();
//       await Get.dialog(const MessageSentDialog());
//     } on AppException catch (e) {
//       AppSnackbar.error(e.message);
//     } finally {
//       if (!isClosed) isSubmitting.value = false;
//     }
//   }
//
//   void emailUs() => ContactActions.emailSupport();
//   void callUs() => ContactActions.callSupport();
//   void whatsappUs() => ContactActions.whatsappSupport();
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     emailController.dispose();
//     subjectController.dispose();
//     messageController.dispose();
//     super.onClose();
//   }
// }

import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/contact_actions.dart';

class HelpSupportController extends GetxController {
  void emailUs() => ContactActions.emailSupport();
  void callUs() => ContactActions.callSupport();
  void whatsappUs() => ContactActions.whatsappSupport();

  void openContactUs() => Get.toNamed(AppRoutes.contactUs);
}