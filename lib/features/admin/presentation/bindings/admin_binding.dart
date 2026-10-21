import 'package:get/get.dart';
import '../controllers/admin_home_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => AdminHomeController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}