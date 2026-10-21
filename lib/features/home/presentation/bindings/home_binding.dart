import 'package:get/get.dart';
import '../../../courses/presentation/controllers/courses_controller.dart';
import '../../../my_learning/presentation/controllers/my_learning_controller.dart';
import '../../../my_learning/presentation/controllers/purchase_status_controller.dart';
import '../../../profile/presentation/controllers/my_profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PurchaseStatusController(Get.find()));
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => CoursesController(Get.find(), Get.find()));
    Get.lazyPut(() => MyLearningController(Get.find()));
    Get.lazyPut(() => MyProfileController(Get.find(), Get.find(), Get.find()));
  }
}