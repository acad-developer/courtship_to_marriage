import 'package:get/get.dart';
import '../controllers/course_form_controller.dart';

class CourseFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseFormController(Get.find()));
  }
}