import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/utils/app_snackbar.dart';
import '../../../../../core/utils/currency.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../my_learning/presentation/controllers/purchase_status_controller.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/usecases/get_user_currency_usecase.dart';
import '../widgets/purchase_confirm_dialog.dart';

class CourseDetailController extends GetxController {
  final CourseEntity course;
  final GetUserCurrencyUseCase _getCurrency;
  final PurchaseStatusController _purchases;

  CourseDetailController(this.course, this._getCurrency, this._purchases);

  Currency get currency => _getCurrency();

  /// Reactive: use inside Obx.
  bool get isPurchased => _purchases.isPurchased(course.id);

  Future<void> share() async {
    try {
      final price = Formatters.money(course.priceIn(currency), currency);
      await SharePlus.instance.share(
        ShareParams(
          subject: course.displayTitle,
          text: 'Check out "${course.displayTitle}" on Courtship to Marriage '
              'for $price.',
        ),
      );
    } catch (_) {
      AppSnackbar.error('Unable to share right now.');
    }
  }

  void buyCourse() {
    if (isPurchased) return;
    Get.dialog(
      PurchaseConfirmDialog(
        course: course,
        currency: currency,
        onConfirm: _onPurchaseConfirmed,
      ),
    );
  }

  void _onPurchaseConfirmed() {
    // TODO: start the real payment flow here later.
    AppSnackbar.success('Payments are coming soon.');
  }
}