import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUser(String uid);
  Future<void> saveUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  UserRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection(AppConstants.usersCollection);

  @override
  Future<UserModel?> getUser(String uid) async {
    final snap = await _users.doc(uid).get();
    final data = snap.data();
    if (!snap.exists || data == null) return null;
    return UserModel.fromMap(uid, data);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final ref = _users.doc(user.uid); // document id = uid
    final snap = await ref.get();

    final data = user.toMap()..['updatedAt'] = FieldValue.serverTimestamp();
    if (!snap.exists) data['createdAt'] = FieldValue.serverTimestamp();

    await ref.set(data, SetOptions(merge: true));
  }
}