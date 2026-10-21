import '../repositories/account_repository.dart';

class DeleteAccountUseCase {
  final AccountRepository _repository;
  DeleteAccountUseCase(this._repository);

  Future<void> call(String uid) => _repository.deleteAccount(uid);
}