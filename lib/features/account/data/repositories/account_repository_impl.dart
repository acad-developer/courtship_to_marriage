import '../../domain/repositories/account_repository.dart';
import '../datasources/account_remote_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource _remote;
  AccountRepositoryImpl(this._remote);

  @override
  Future<void> deleteAccount(String uid) => _remote.deleteAccount(uid);
}