import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_exception.dart';

abstract class AccountRemoteDataSource {
  Future<void> deleteAccount(String uid);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  AccountRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<void> deleteAccount(String uid) async {
    final user = _auth.currentUser;
    if (user == null || user.uid != uid) {
      throw const AppException('Please sign in again and retry.');
    }

    // 1) Firestore data first: it needs the user to still be signed in.
    try {
      final userRef =
      _firestore.collection(AppConstants.usersCollection).doc(uid);

      await _deleteAll(await userRef.collection('purchases').get());
      await _deleteAll(await _firestore
          .collection('supportQueries')
          .where('uid', isEqualTo: uid)
          .get());
      await userRef.delete();
    } on FirebaseException {
      throw const AppException(
          "We couldn't delete your data. Please check your connection and try again.");
    }

    // 2) The Auth account last.
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const AppException(
            'For your security, please verify your phone number again.');
      }
      throw AppException(e.message ?? 'Could not delete your account.');
    }
  }

  /// Deletes in batches of 400 (Firestore allows at most 500 per batch).
  Future<void> _deleteAll(QuerySnapshot<Map<String, dynamic>> snap) async {
    final docs = snap.docs;
    for (var i = 0; i < docs.length; i += 400) {
      final batch = _firestore.batch();
      for (final d in docs.skip(i).take(400)) {
        batch.delete(d.reference);
      }
      await batch.commit();
    }
  }
}