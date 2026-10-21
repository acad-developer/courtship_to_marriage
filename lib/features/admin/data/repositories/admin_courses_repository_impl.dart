import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/admin_course.dart';
import '../../domain/repositories/admin_courses_repository.dart';
import '../datasources/admin_courses_remote_datasource.dart';

class AdminCoursesRepositoryImpl implements AdminCoursesRepository {
  final AdminCoursesRemoteDataSource _remote;
  AdminCoursesRepositoryImpl(this._remote);

  @override
  Stream<List<AdminCourse>> watchCourses() {
    return _remote.watchCourses().transform(
      StreamTransformer<List<AdminCourse>, List<AdminCourse>>.fromHandlers(
        handleData: (data, sink) => sink.add(data),
        handleError: (error, stack, sink) => sink.addError(
          error is FirebaseException ? mapFirebaseException(error) : error,
          stack,
        ),
      ),
    );
  }

  @override
  String newCourseId() => _remote.newCourseId();

  @override
  Future<void> saveCourse(AdminCourse course, {required bool isNew}) =>
      _guard(() => _remote.saveCourse(course, isNew: isNew));

  @override
  Future<void> updateStatus(String courseId, CourseStatus status) =>
      _guard(() => _remote.updateStatus(courseId, status));

  @override
  Future<List<String>> deleteCourse(String courseId) =>
      _guard(() => _remote.deleteCourse(courseId));

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}