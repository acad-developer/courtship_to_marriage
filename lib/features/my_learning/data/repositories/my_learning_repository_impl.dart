import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/errors/firebase_error_mapper.dart';
import '../../../courses/domain/entities/course_entity.dart';
import '../../../courses/domain/repositories/courses_repository.dart';
import '../../domain/repositories/my_learning_repository.dart';
import '../datasources/my_learning_remote_datasource.dart';

class MyLearningRepositoryImpl implements MyLearningRepository {
  final MyLearningRemoteDataSource _remote;
  final CoursesRepository _courses;

  MyLearningRepositoryImpl(this._remote, this._courses);

  @override
  Future<List<CourseEntity>> getPurchasedCourses() async {
    try {
      final ids = (await _remote.getPurchasedCourseIds()).toSet();
      if (ids.isEmpty) return const [];

      // Only published courses can be listed, so an unpublished purchased
      // course is hidden until the admin publishes it again.
      final all = await _courses.getCourses();
      return all.where((c) => ids.contains(c.id)).toList();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<Set<String>> getPurchasedCourseIds() async {
    try {
      return (await _remote.getPurchasedCourseIds()).toSet();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}