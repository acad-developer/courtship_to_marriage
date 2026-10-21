import '../../../../core/errors/app_exception.dart';
import '../entities/support_query.dart';
import '../repositories/support_repository.dart';

class SubmitSupportQueryUseCase {
  final SupportRepository _repository;
  SubmitSupportQueryUseCase(this._repository);

  Future<void> call(SupportQuery query) => _repository.submitQuery(query);
}

class WatchSupportQueriesUseCase {
  final SupportRepository _repository;
  WatchSupportQueriesUseCase(this._repository);

  Stream<List<SupportQuery>> call() => _repository.watchQueries();
}

class WatchPendingQueriesCountUseCase {
  final SupportRepository _repository;
  WatchPendingQueriesCountUseCase(this._repository);

  Stream<int> call() => _repository.watchPendingCount();
}

class ResolveSupportQueryUseCase {
  final SupportRepository _repository;
  ResolveSupportQueryUseCase(this._repository);

  Future<void> call(String id) => _repository.markResolved(id);
}

class DeleteSupportQueryUseCase {
  final SupportRepository _repository;
  DeleteSupportQueryUseCase(this._repository);

  Future<void> call(SupportQuery query) {
    if (!query.isResolved) {
      throw const AppException('Only resolved queries can be deleted.');
    }
    return _repository.deleteQuery(query.id);
  }
}