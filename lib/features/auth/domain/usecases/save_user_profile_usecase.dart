import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SaveUserProfileUseCase {
  final UserRepository _repository;
  SaveUserProfileUseCase(this._repository);

  Future<void> call(UserEntity user) => _repository.saveUser(user);
}