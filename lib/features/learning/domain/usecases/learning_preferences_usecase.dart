import '../repositories/learning_preferences_repository.dart';

class GetAutoPlayNextUseCase {
  final LearningPreferencesRepository _repository;
  GetAutoPlayNextUseCase(this._repository);

  Future<bool> call() => _repository.getAutoPlayNext();
}

class SetAutoPlayNextUseCase {
  final LearningPreferencesRepository _repository;
  SetAutoPlayNextUseCase(this._repository);

  Future<void> call(bool value) => _repository.setAutoPlayNext(value);
}