import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/admin_course.dart';
import '../models/admin_course_model.dart';

abstract class AdminCoursesRemoteDataSource {
  Stream<List<AdminCourse>> watchCourses();
  String newCourseId();
  Future<void> saveCourse(AdminCourse course, {required bool isNew});
  Future<void> updateStatus(String courseId, CourseStatus status);
  Future<List<String>> deleteCourse(String courseId);
}

class AdminCoursesRemoteDataSourceImpl implements AdminCoursesRemoteDataSource {
  final FirebaseFirestore _firestore;
  AdminCoursesRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _courses =>
      _firestore.collection('courses');

  @override
  Stream<List<AdminCourse>> watchCourses() {
    return _courses
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((d) => AdminCourseModel.fromMap(d.id, d.data()))
        .toList());
  }

  @override
  String newCourseId() => _courses.doc().id;

  @override
  Future<void> saveCourse(AdminCourse course, {required bool isNew}) async {
    final data = AdminCourseModel.toMap(course)
      ..['updatedAt'] = FieldValue.serverTimestamp();

    if (isNew) {
      data['createdAt'] = FieldValue.serverTimestamp();
      data['lessonCount'] = 0;
      data['totalDurationSeconds'] = 0;
    }
    // merge: true keeps lessonCount / totalDurationSeconds on edits.
    await _courses.doc(course.id).set(data, SetOptions(merge: true));
  }

  @override
  Future<void> updateStatus(String courseId, CourseStatus status) {
    return _courses.doc(courseId).update({
      'status': status.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<List<String>> deleteCourse(String courseId) async {
    final courseRef = _courses.doc(courseId);
    final lessons = await courseRef.collection('lessons').get();

    final files = <String>[];
    for (final d in lessons.docs) {
      final path = d.data()['thumbnailPath'] as String?;
      if (path != null && path.isNotEmpty) files.add(path);
    }

    // Firestore does not cascade: delete lessons in batches first.
    for (var i = 0; i < lessons.docs.length; i += 400) {
      final batch = _firestore.batch();
      for (final d in lessons.docs.skip(i).take(400)) {
        batch.delete(d.reference);
      }
      await batch.commit();
    }

    await courseRef.delete();
    return files;
  }
}