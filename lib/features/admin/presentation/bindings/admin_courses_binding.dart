import 'package:get/get.dart';
import '../controllers/admin_courses_controller.dart';

class AdminCoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminCoursesController(Get.find(), Get.find(), Get.find()));
  }
}