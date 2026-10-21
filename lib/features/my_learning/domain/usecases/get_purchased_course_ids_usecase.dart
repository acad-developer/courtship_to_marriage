import '../repositories/my_learning_repository.dart';

class GetPurchasedCourseIdsUseCase {
  final MyLearningRepository _repository;
  GetPurchasedCourseIdsUseCase(this._repository);

  Future<Set<String>> call() => _repository.getPurchasedCourseIds();
}