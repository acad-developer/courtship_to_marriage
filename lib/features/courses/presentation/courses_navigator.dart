// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/routes/nested_routes.dart';
// import 'views/courses_view.dart';
//
// class CoursesNavigator extends StatelessWidget {
//   final VoidCallback onBack;
//   const CoursesNavigator({super.key, required this.onBack});
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: Get.nestedKey(NestedNavKeys.courses),
//       initialRoute: CoursesRoutes.list,
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case CoursesRoutes.list:
//             return GetPageRoute(
//               settings: settings,
//               page: () => CoursesView(onBack: onBack),
//             );
//         // Step 2 adds CoursesRoutes.detail here.
//           default:
//             return null;
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/nested_routes.dart';
import '../domain/entities/course_entity.dart';
import 'views/course_detail_view.dart';
import 'views/courses_view.dart';

class CoursesNavigator extends StatelessWidget {
  final VoidCallback onBack;
  const CoursesNavigator({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NestedNavKeys.courses),
      initialRoute: CoursesRoutes.list,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CoursesRoutes.list:
            return GetPageRoute(
              settings: settings,
              page: () => CoursesView(onBack: onBack),
            );
          case CoursesRoutes.detail:
            final course = settings.arguments as CourseEntity;
            return GetPageRoute(
              settings: settings,
              page: () => CourseDetailView(course: course),
            );
          default:
            return null;
        }
      },
    );
  }
}