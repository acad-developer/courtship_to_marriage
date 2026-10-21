import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_datasource.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource _remote;
  CoursesRepositoryImpl(this._remote);

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      return await _remote.getPublishedCourses();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}