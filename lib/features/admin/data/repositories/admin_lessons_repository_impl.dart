import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/admin_lesson.dart';
import '../../domain/repositories/admin_lessons_repository.dart';
import '../datasources/admin_lessons_remote_datasource.dart';

class AdminLessonsRepositoryImpl implements AdminLessonsRepository {
  final AdminLessonsRemoteDataSource _remote;
  AdminLessonsRepositoryImpl(this._remote);

  @override
  Stream<List<AdminLesson>> watchLessons(String courseId) {
    return _remote.watchLessons(courseId).transform(
      StreamTransformer<List<AdminLesson>, List<AdminLesson>>.fromHandlers(
        handleData: (data, sink) => sink.add(data),
        handleError: (error, stack, sink) => sink.addError(
          error is FirebaseException ? mapFirebaseException(error) : error,
          stack,
        ),
      ),
    );
  }

  @override
  String newLessonId(String courseId) => _remote.newLessonId(courseId);

  @override
  Future<void> saveLesson(AdminLesson lesson, {required bool isNew}) =>
      _guard(() => _remote.saveLesson(lesson, isNew: isNew));

  @override
  Future<void> deleteLesson(String courseId, String lessonId) =>
      _guard(() => _remote.deleteLesson(courseId, lessonId));

  @override
  Future<void> reorderLessons(String courseId, List<String> orderedIds) =>
      _guard(() => _remote.reorderLessons(courseId, orderedIds));

  @override
  Future<void> recalculateCourseTotals(String courseId) =>
      _guard(() => _remote.recalculateCourseTotals(courseId));

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}