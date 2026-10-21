import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.phoneNumber,
    super.role,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromEntity(UserEntity e) => UserModel(
    uid: e.uid,
    name: e.name,
    email: e.email,
    phoneNumber: e.phoneNumber,
    role: e.role,
    createdAt: e.createdAt,
    updatedAt: e.updatedAt,
  );

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) => UserModel(
    uid: uid,
    name: (map['name'] as String?) ?? '',
    email: (map['email'] as String?) ?? '',
    phoneNumber: (map['phoneNumber'] as String?) ?? '',
    role: (map['role'] as String?) ?? 'user',
    createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
  );

  /// 'role' is intentionally NOT written: the app can never change it.
  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
  };
}