import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_auth_user_usecase.dart';
import '../../domain/usecases/save_user_profile_usecase.dart';

class ProfileController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final SaveUserProfileUseCase _saveUserProfile;

  ProfileController(this._getCurrentAuthUser, this._saveUserProfile);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final isSaving = false.obs;

  AuthUser? _authUser;

  @override
  void onInit() {
    super.onInit();
    _authUser = _getCurrentAuthUser();
  }

  Future<void> save() async {
    final authUser = _authUser;
    if (authUser == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    isSaving.value = true;
    try {
      await _saveUserProfile(UserEntity(
        uid: authUser.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim().toLowerCase(),
        phoneNumber: authUser.phoneNumber ?? '',
      ));
      Get.offAllNamed(AppRoutes.home);
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}