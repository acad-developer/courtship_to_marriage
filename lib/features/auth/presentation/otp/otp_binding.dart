import 'package:get/get.dart';
import 'otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController(Get.find(), Get.find(), Get.find()));
  }
}