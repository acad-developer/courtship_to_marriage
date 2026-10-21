import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentAuthUserUseCase {
  final AuthRepository _repository;
  GetCurrentAuthUserUseCase(this._repository);

  AuthUser? call() => _repository.currentUser;
}