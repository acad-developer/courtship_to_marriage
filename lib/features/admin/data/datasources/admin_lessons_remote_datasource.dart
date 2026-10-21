import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_lesson.dart';
import '../models/admin_lesson_model.dart';

abstract class AdminLessonsRemoteDataSource {
  Stream<List<AdminLesson>> watchLessons(String courseId);
  String newLessonId(String courseId);
  Future<void> saveLesson(AdminLesson lesson, {required bool isNew});
  Future<void> deleteLesson(String courseId, String lessonId);
  Future<void> reorderLessons(String courseId, List<String> orderedIds);
  Future<void> recalculateCourseTotals(String courseId);
}

class AdminLessonsRemoteDataSourceImpl implements AdminLessonsRemoteDataSource {
  final FirebaseFirestore _firestore;
  AdminLessonsRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> _lessons(String courseId) =>
      _firestore.collection('courses').doc(courseId).collection('lessons');

  @override
  Stream<List<AdminLesson>> watchLessons(String courseId) {
    return _lessons(courseId).orderBy('order').snapshots().map((snap) => snap
        .docs
        .map((d) => AdminLessonModel.fromMap(courseId, d.id, d.data()))
        .toList());
  }

  @override
  String newLessonId(String courseId) => _lessons(courseId).doc().id;

  @override
  Future<void> saveLesson(AdminLesson lesson, {required bool isNew}) async {
    final data = AdminLessonModel.toMap(lesson)
      ..['updatedAt'] = FieldValue.serverTimestamp();
    if (isNew) {
      data['order'] = lesson.order;
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    await _lessons(lesson.courseId)
        .doc(lesson.id)
        .set(data, SetOptions(merge: true));
  }

  @override
  Future<void> deleteLesson(String courseId, String lessonId) =>
      _lessons(courseId).doc(lessonId).delete();

  @override
  Future<void> reorderLessons(String courseId, List<String> orderedIds) async {
    final batch = _firestore.batch();
    for (var i = 0; i < orderedIds.length; i++) {
      batch.update(_lessons(courseId).doc(orderedIds[i]), {'order': i + 1});
    }
    await batch.commit();
  }

  @override
  Future<void> recalculateCourseTotals(String courseId) async {
    final snap = await _lessons(courseId).get();
    var seconds = 0;
    for (final d in snap.docs) {
      seconds += (d.data()['durationSeconds'] as num?)?.toInt() ?? 0;
    }
    await _firestore.collection('courses').doc(courseId).update({
      'lessonCount': snap.docs.length,
      'totalDurationSeconds': seconds,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}