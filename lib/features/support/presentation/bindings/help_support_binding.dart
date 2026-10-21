// import 'package:get/get.dart';
// import '../controllers/help_support_controller.dart';
//
// class HelpSupportBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => HelpSupportController(Get.find(), Get.find(), Get.find()));
//   }
// }
import 'package:get/get.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpSupportController());
  }
}