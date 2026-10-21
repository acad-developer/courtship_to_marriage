import 'dart:async';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../../auth/domain/usecases/get_user_profile_usecase.dart';
import '../../../auth/domain/usecases/sign_out_usecase.dart';
import '../../../profile/presentation/widgets/sign_out_dialog.dart';
import '../../../support/domain/usecases/support_usecases.dart';

class AdminHomeController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final GetUserProfileUseCase _getUserProfile;
  final SignOutUseCase _signOut;
  final WatchPendingQueriesCountUseCase _watchPending;

  AdminHomeController(
      this._getCurrentAuthUser,
      this._getUserProfile,
      this._signOut,
      this._watchPending,
      );

  final name = ''.obs;
  final isLoading = true.obs;
  final isSigningOut = false.obs;
  final pendingCount = 0.obs;

  StreamSubscription<int>? _pendingSub;

  @override
  void onInit() {
    super.onInit();
    _verifyAdmin();
    _pendingSub = _watchPending().listen(
          (n) => pendingCount.value = n,
      onError: (_) {},
    );
  }

  /// Safety net: only real admins may stay on this screen.
  /// (The Firestore/Storage rules are the actual protection.)
  Future<void> _verifyAdmin() async {
    final authUser = _getCurrentAuthUser();
    if (authUser == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    try {
      final profile = await _getUserProfile(authUser.uid);
      if (profile == null || !profile.isAdmin) {
        Get.offAllNamed(AppRoutes.splash); // re-route by role
        return;
      }
      name.value = profile.name;
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void openCourses() => Get.toNamed(AppRoutes.adminCourses);
  void openSupport() => Get.toNamed(AppRoutes.adminSupport);

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

  @override
  void onClose() {
    _pendingSub?.cancel();
    super.onClose();
  }
}