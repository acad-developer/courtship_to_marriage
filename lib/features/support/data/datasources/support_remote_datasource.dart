import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/support_query.dart';
import '../models/support_query_model.dart';

abstract class SupportRemoteDataSource {
  Future<void> submit(SupportQuery query);
  Stream<List<SupportQuery>> watchQueries();
  Stream<int> watchPendingCount();
  Future<void> markResolved(String id);
  Future<void> delete(String id);
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final FirebaseFirestore _firestore;
  SupportRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('supportQueries');

  @override
  Future<void> submit(SupportQuery query) =>
      _col.add(SupportQueryModel.toCreateMap(query));

  @override
  Stream<List<SupportQuery>> watchQueries() {
    return _col
        .orderBy('createdAt', descending: true)
        .limit(200)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => SupportQueryModel.fromMap(d.id, d.data()))
            .toList());
  }

  @override
  Stream<int> watchPendingCount() => _col
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((snap) => snap.size);

  @override
  Future<void> markResolved(String id) => _col.doc(id).update({
        'status': 'resolved',
        'resolvedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  @override
  Future<void> delete(String id) => _col.doc(id).delete();
}