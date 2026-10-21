/// Ids of nested navigators (used with Get.toNamed(..., id: ...)).
class NestedNavKeys {
  NestedNavKeys._();
  static const courses = 1;
}

class CoursesRoutes {
  CoursesRoutes._();
  static const list = '/courses';
  static const detail = '/courses/detail'; // added in step 2
}