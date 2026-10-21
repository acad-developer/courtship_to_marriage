import '../../../courses/domain/entities/course_entity.dart';
import '../repositories/my_learning_repository.dart';

class GetPurchasedCoursesUseCase {
  final MyLearningRepository _repository;
  GetPurchasedCoursesUseCase(this._repository);

  Future<List<CourseEntity>> call() => _repository.getPurchasedCourses();
}