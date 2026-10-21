import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/course_entity.dart';
import '../models/course_model.dart';

abstract class CoursesRemoteDataSource {
  Future<List<CourseEntity>> getPublishedCourses();
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final FirebaseFirestore _firestore;
  CoursesRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<CourseEntity>> getPublishedCourses() async {
    final snap = await _firestore
        .collection('courses')
        .where('status', isEqualTo: 'published')
        .get();

    final list =
    snap.docs.map((d) => CourseModel.fromMap(d.id, d.data())).toList();

    final epoch = DateTime.fromMillisecondsSinceEpoch(0);
    list.sort((a, b) =>
        (b.createdAt ?? epoch).compareTo(a.createdAt ?? epoch)); // newest first
    return list;
  }
}