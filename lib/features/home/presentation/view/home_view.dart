import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/routes/nested_routes.dart';
import '../../../courses/presentation/courses_navigator.dart';
import '../../../my_learning/presentation/views/my_learning_view.dart';
import '../../../profile/presentation/views/my_profile_view.dart';
import '../controllers/home_controller.dart';
import 'home_tab.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void _handleBack(int tab) {
    // 1) Inside Courses tab with a detail page open: pop it.
    final nested = Get.nestedKey(NestedNavKeys.courses)?.currentState;
    if (tab == 1 && nested != null && nested.canPop()) {
      nested.pop();
      return;
    }
    // 2) On any other tab: go back to Home tab.
    if (tab != 0) {
      controller.changeTab(0);
      return;
    }
    // 3) On Home tab: leave the app.
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tab = controller.currentTab.value;
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _handleBack(tab);
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: IndexedStack(
            index: tab,
            children: [
              const HomeTab(),
              CoursesNavigator(onBack: () => controller.changeTab(0)),
              MyLearningView(onExplore: () => controller.changeTab(1)),
              const MyProfileView(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: BottomNavigationBar(
              currentIndex: tab,
              onTap: controller.changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.hint,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded), label: 'Courses'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school_rounded), label: 'My Learning'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
            ),
          ),
        ),
      );
    });
  }
}