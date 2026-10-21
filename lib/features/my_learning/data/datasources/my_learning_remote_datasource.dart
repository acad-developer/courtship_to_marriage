import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MyLearningRemoteDataSource {
  Future<List<String>> getPurchasedCourseIds();
}

class MyLearningRemoteDataSourceImpl implements MyLearningRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  MyLearningRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<List<String>> getPurchasedCourseIds() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const [];

    final snap = await _firestore
        .collection('users')
        .doc(uid)
        .collection('purchases')
        .get();
    return snap.docs
        .map((d) => (d.data()['courseId'] as String?) ?? d.id)
        .toList();
  }
}