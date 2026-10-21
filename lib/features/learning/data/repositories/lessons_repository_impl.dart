import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/repositories/lessons_repository.dart';
import '../datasources/learning_remote_datasource.dart';

class LessonsRepositoryImpl implements LessonsRepository {
  final LearningRemoteDataSource _remote;
  LessonsRepositoryImpl(this._remote);

  @override
  Future<List<LessonEntity>> getLessons(String courseId) async {
    try {
      return await _remote.getLessons(courseId);
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}