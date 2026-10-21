import 'package:get/get.dart';
import '../controllers/lesson_form_controller.dart';

class LessonFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonFormController(Get.find(), Get.find()));
  }
}