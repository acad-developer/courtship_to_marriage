import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/lesson_entity.dart';
import '../models/lesson_model.dart';

abstract class LearningRemoteDataSource {
  Future<List<LessonEntity>> getLessons(String courseId);
}

class LearningRemoteDataSourceImpl implements LearningRemoteDataSource {
  final FirebaseFirestore _firestore;
  LearningRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<LessonEntity>> getLessons(String courseId) async {
    final snap = await _firestore
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .orderBy('order')
        .get();
    return snap.docs.map((d) => LessonModel.fromMap(d.id, d.data())).toList();
  }
}