import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _local;
  HomeRepositoryImpl(this._local);

  @override
  Future<List<CourseEntity>> getCourses() => _local.getCourses();
}