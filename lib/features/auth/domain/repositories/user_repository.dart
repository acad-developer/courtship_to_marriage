import '../entities/user_entity.dart';

abstract class UserRepository {
  /// Returns null if the user document does not exist.
  Future<UserEntity?> getUser(String uid);
  Future<void> saveUser(UserEntity user);
}