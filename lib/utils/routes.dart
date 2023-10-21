import 'package:courtship_to_marriage/view/page/auth/login.dart';
import 'package:courtship_to_marriage/view/page/blog/blog.dart';
import 'package:courtship_to_marriage/view/page/main/main_screen.dart';
import 'package:courtship_to_marriage/view/page/auth/register.dart';
import 'package:courtship_to_marriage/view/page/splash/splash.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

routes() => [
      GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: AppRoutes.register,
        page: () => const RegisterScreen(),
      ),
      GetPage(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: AppRoutes.main,
        page: () => const MainScreen(),
      ),
      GetPage(
        name: AppRoutes.blog,
        page: () => const BlogScreen(),
      ),
    ];
