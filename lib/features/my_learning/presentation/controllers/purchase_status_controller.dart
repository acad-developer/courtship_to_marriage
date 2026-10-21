import 'package:get/get.dart';
import '../../domain/usecases/get_purchased_course_ids_usecase.dart';

class PurchaseStatusController extends GetxController {
  final GetPurchasedCourseIdsUseCase _getIds;
  PurchaseStatusController(this._getIds);

  final purchasedIds = <String>[].obs;

  bool isPurchased(String courseId) => purchasedIds.contains(courseId);

  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  Future<void> refresh() async {
    try {
      purchasedIds.assignAll(await _getIds());
    } catch (_) {
      // Keep the last known state if the refresh fails.
    }
  }
}