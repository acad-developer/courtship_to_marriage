class CourseEntity {
  final String id;
  final String title;
  final String description;
  final double price;
  final String language;
  final String imageUrl;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.imageUrl,
  });
}