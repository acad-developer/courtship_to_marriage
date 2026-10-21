import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/support_query.dart';

class SupportQueryModel {
  SupportQueryModel._();

  static SupportQuery fromMap(String id, Map<String, dynamic> m) =>
      SupportQuery(
        id: id,
        uid: (m['uid'] as String?) ?? '',
        name: (m['name'] as String?) ?? '',
        email: (m['email'] as String?) ?? '',
        phone: (m['phone'] as String?) ?? '',
        subject: (m['subject'] as String?) ?? '',
        message: (m['message'] as String?) ?? '',
        status: m['status'] == 'resolved'
            ? QueryStatus.resolved
            : QueryStatus.pending,
        createdAt: (m['createdAt'] as Timestamp?)?.toDate(),
        resolvedAt: (m['resolvedAt'] as Timestamp?)?.toDate(),
      );

  static Map<String, dynamic> toCreateMap(SupportQuery q) => {
    'uid': q.uid,
    'name': q.name,
    'email': q.email,
    'phone': q.phone,
    'subject': q.subject,
    'message': q.message,
    'status': 'pending',
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };
}