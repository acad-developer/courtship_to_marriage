import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/errors/app_exception.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_snackbar.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../../auth/domain/usecases/get_user_profile_usecase.dart';
import '../../../auth/domain/usecases/save_user_profile_usecase.dart';

class EditProfileController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final GetUserProfileUseCase _getUserProfile;
  final SaveUserProfileUseCase _saveUserProfile;

  EditProfileController(
      this._getCurrentAuthUser,
      this._getUserProfile,
      this._saveUserProfile,
      );

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phone = ''.obs;
  final isLoading = true.obs;
  final isSaving = false.obs;

  AuthUser? _authUser;
  String _initialName = '';
  String _initialEmail = '';

  @override
  void onInit() {
    super.onInit();
    _authUser = _getCurrentAuthUser();
    _load();
  }

  Future<void> _load() async {
    final user = _authUser;
    if (user == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    phone.value = user.phoneNumber ?? '';

    try {
      final profile = await _getUserProfile(user.uid);
      if (profile != null) {
        nameController.text = profile.name;
        emailController.text = profile.email;
        if (profile.phoneNumber.isNotEmpty) phone.value = profile.phoneNumber;
      }
      _initialName = nameController.text.trim();
      _initialEmail = emailController.text.trim().toLowerCase();
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> save() async {
    final user = _authUser;
    if (user == null) return;
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final name = nameController.text.trim();
    final email = emailController.text.trim().toLowerCase();

    // Nothing changed: just go back.
    if (name == _initialName && email == _initialEmail) {
      Get.back();
      return;
    }

    isSaving.value = true;
    try {
      await _saveUserProfile(UserEntity(
        uid: user.uid,
        name: name,
        email: email,
        phoneNumber: phone.value,
      ));
      Get.back(result: true); // tells the Profile tab to refresh
      AppSnackbar.success('Profile updated successfully.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      if (!isClosed) isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}