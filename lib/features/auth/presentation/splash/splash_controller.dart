import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/usecases/get_current_auth_user_usecase.dart';
import '../../domain/usecases/get_post_auth_destination_usecase.dart';
import '../post_auth_navigation.dart';

class SplashController extends GetxController {
  final GetCurrentAuthUserUseCase _getCurrentAuthUser;
  final GetPostAuthDestinationUseCase _getPostAuthDestination;

  SplashController(this._getCurrentAuthUser, this._getPostAuthDestination);

  final hasError = false.obs;

  @override
  void onReady() {
    super.onReady();
    start();
  }

  Future<void> start() async {
    hasError.value = false;
    await Future.delayed(AppConstants.splashDelay);

    final authUser = _getCurrentAuthUser();
    if (authUser == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    try {
      final destination = await _getPostAuthDestination(authUser.uid);
      Get.offAllNamed(destination.route);
    } on AppException {
      hasError.value = true; // show retry button
    }
  }
}