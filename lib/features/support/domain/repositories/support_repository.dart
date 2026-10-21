import '../entities/support_query.dart';

abstract class SupportRepository {
  Future<void> submitQuery(SupportQuery query);
  Stream<List<SupportQuery>> watchQueries();
  Stream<int> watchPendingCount();
  Future<void> markResolved(String id);
  Future<void> deleteQuery(String id);
}