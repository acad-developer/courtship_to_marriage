enum QueryStatus { pending, resolved }

class SupportQuery {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final QueryStatus status;
  final DateTime? createdAt;
  final DateTime? resolvedAt;

  const SupportQuery({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
    this.status = QueryStatus.pending,
    this.createdAt,
    this.resolvedAt,
  });

  bool get isResolved => status == QueryStatus.resolved;
}