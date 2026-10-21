import '../../domain/entities/course_entity.dart';

abstract class HomeLocalDataSource {
  Future<List<CourseEntity>> getCourses();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<CourseEntity>> getCourses() async {
    return const [
      CourseEntity(
        id: '1',
        title: 'Foundations of Courtship',
        description:
        'A comprehensive guide to understanding your partner and building a lasting bond.',
        price: 49.99,
        language: 'English',
        imageUrl: 'https://picsum.photos/seed/courtship-en/800/600',
      ),
      CourseEntity(
        id: '2',
        title: 'विवाह की तैयारी',
        description:
        'रिश्ते को मजबूत बनाने के लिए एक संपूर्ण मार्गदर्शिका।',
        price: 39.99,
        language: 'Hindi',
        imageUrl: 'https://picsum.photos/seed/courtship-hi/800/600',
      ),
    ];
  }
}