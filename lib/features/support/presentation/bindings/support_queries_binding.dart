import 'package:get/get.dart';
import '../controllers/support_queries_controller.dart';

class SupportQueriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => SupportQueriesController(Get.find(), Get.find(), Get.find()));
  }
}