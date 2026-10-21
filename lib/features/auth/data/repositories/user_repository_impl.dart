import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remote;
  UserRepositoryImpl(this._remote);

  static const _networkError =
  AppException('Unable to reach the server. Please check your connection.');

  @override
  Future<UserEntity?> getUser(String uid) async {
    try {
      return await _remote.getUser(uid);
    } on FirebaseException {
      throw _networkError;
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    try {
      await _remote.saveUser(UserModel.fromEntity(user));
    } on FirebaseException {
      throw _networkError;
    }
  }
}