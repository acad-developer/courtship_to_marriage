import 'package:get/get.dart';
import '../../features/about/presentation/views/about_view.dart';
import '../../features/auth/presentation/login/login_binding.dart';
import '../../features/auth/presentation/login/login_view.dart';
import '../../features/auth/presentation/otp/otp_binding.dart';
import '../../features/auth/presentation/otp/otp_view.dart';
import '../../features/auth/presentation/profile/profile_binding.dart';
import '../../features/auth/presentation/profile/profile_view.dart';
import '../../features/auth/presentation/splash/splash_binding.dart';
import '../../features/auth/presentation/splash/splash_view.dart';
import '../../features/contact/presentation/bindings/contact_us_binding.dart';
import '../../features/contact/presentation/views/contact_us_view.dart';
import '../../features/legal/presentation/views/privacy_policy_view.dart';
import '../../features/legal/presentation/views/terms_view.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/learning/presentation/views/lesson_player_view.dart';
import '../../features/profile/presentation/bindings/edit_profile_binding.dart';
import '../../features/profile/presentation/views/edit_profile_view.dart';
import '../../features/admin/presentation/bindings/admin_binding.dart';
import '../../features/admin/presentation/views/admin_home_view.dart';
import '../../features/admin/presentation/bindings/admin_courses_binding.dart';
import '../../features/admin/presentation/bindings/course_form_binding.dart';
import '../../features/admin/presentation/views/admin_courses_view.dart';
import '../../features/admin/presentation/views/course_form_view.dart';
import '../../features/admin/presentation/bindings/admin_lessons_binding.dart';
import '../../features/admin/presentation/bindings/lesson_form_binding.dart';
import '../../features/admin/presentation/views/admin_lessons_view.dart';
import '../../features/admin/presentation/views/lesson_form_view.dart';
import '../../features/learning/presentation/bindings/course_lessons_binding.dart';
import '../../features/learning/presentation/bindings/lesson_player_binding.dart';
import '../../features/learning/presentation/views/course_lessons_view.dart';
import '../../features/support/presentation/bindings/help_support_binding.dart';
import '../../features/support/presentation/bindings/support_queries_binding.dart';
import '../../features/support/presentation/views/help_support_view.dart';
import '../../features/support/presentation/views/support_queries_view.dart';
import '../../features/account/presentation/bindings/delete_account_binding.dart';
import '../../features/account/presentation/views/delete_account_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.adminHome,
      page: () => const AdminHomeView(),
      binding: AdminBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.adminCourses,
      page: () => const AdminCoursesView(),
      binding: AdminCoursesBinding(),
    ),
    GetPage(
      name: AppRoutes.adminCourseForm,
      page: () => const CourseFormView(),
      binding: CourseFormBinding(),
    ),
    GetPage(
      name: AppRoutes.adminLessons,
      page: () => const AdminLessonsView(),
      binding: AdminLessonsBinding(),
    ),
    GetPage(
      name: AppRoutes.adminLessonForm,
      page: () => const LessonFormView(),
      binding: LessonFormBinding(),
    ),
    GetPage(
      name: AppRoutes.courseLessons,
      page: () => const CourseLessonsView(),
      binding: CourseLessonsBinding(),
    ),
    GetPage(
      name: AppRoutes.lessonPlayer,
      page: () => const LessonPlayerView(),
      binding: LessonPlayerBinding(),
    ),
    GetPage(
      name: AppRoutes.helpSupport,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: AppRoutes.adminSupport,
      page: () => const SupportQueriesView(),
      binding: SupportQueriesBinding(),
    ),
    GetPage(name: AppRoutes.privacyPolicy, page: () => const PrivacyPolicyView()),
    GetPage(name: AppRoutes.terms, page: () => const TermsView()),
    GetPage(name: AppRoutes.about, page: () => const AboutView()),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: AppRoutes.deleteAccount,
      page: () => const DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
  ];
}