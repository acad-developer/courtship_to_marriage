import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../core/errors/app_exception.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_snackbar.dart';
import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../../auth/domain/usecases/get_user_profile_usecase.dart';
import '../../../auth/domain/usecases/sign_out_usecase.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../widgets/sign_out_dialog.dart';

class MyProfileController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final GetUserProfileUseCase _getUserProfile;
  final SignOutUseCase _signOut;

  MyProfileController(
      this._getCurrentAuthUser,
      this._getUserProfile,
      this._signOut,
      );

  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final version = ''.obs;
  final isLoading = true.obs;
  final isSigningOut = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    _loadVersion();
  }

  Future<void> loadProfile() async {
    final authUser = _getCurrentAuthUser();
    if (authUser == null) {
      isLoading.value = false;
      return;
    }
    phone.value = authUser.phoneNumber ?? '';
    try {
      final profile = await _getUserProfile(authUser.uid);
      if (profile != null) {
        name.value = profile.name;
        email.value = profile.email;
        if (profile.phoneNumber.isNotEmpty) phone.value = profile.phoneNumber;
      }
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      version.value = 'Version ${info.version}';
    } catch (_) {
      version.value = '';
    }
  }

  Future<void> openEditProfile() async {
    final updated = await Get.toNamed(AppRoutes.editProfile);
    if (updated == true) {
      await loadProfile();
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshUserName();
      }
    }
  }

  void openInfoItem(String title) {
    switch (title) {
      case 'Help & Support':
        Get.toNamed(AppRoutes.helpSupport);
        return;
      case 'Contact Us':
        Get.toNamed(AppRoutes.contactUs);
        return;
      case 'About Us':
        Get.toNamed(AppRoutes.about);
        return;
      case 'Privacy Policy':
        Get.toNamed(AppRoutes.privacyPolicy);
        return;
      case 'Terms & Conditions':
        Get.toNamed(AppRoutes.terms);
        return;
    }
  }

  Future<void> confirmSignOut() async {
    final confirmed = await Get.dialog<bool>(const SignOutDialog()) ?? false;
    if (!confirmed) return;

    isSigningOut.value = true;
    try {
      await _signOut();
      Get.offAllNamed(AppRoutes.login);
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      if (!isClosed) isSigningOut.value = false;
    }
  }

  void openDeleteAccount() => Get.toNamed(AppRoutes.deleteAccount);
}