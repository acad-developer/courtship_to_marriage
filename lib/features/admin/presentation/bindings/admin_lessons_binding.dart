import 'package:get/get.dart';
import '../controllers/admin_lessons_controller.dart';

class AdminLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminLessonsController(Get.find(), Get.find(), Get.find()));
  }
}