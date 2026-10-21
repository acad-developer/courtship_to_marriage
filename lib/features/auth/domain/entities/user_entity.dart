class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  /// 'user' (default) or 'admin'. Set manually in Firestore, never by the app.
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.role = 'user',
    this.createdAt,
    this.updatedAt,
  });

  bool get isAdmin => role == 'admin';
}