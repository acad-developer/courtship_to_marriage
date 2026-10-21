import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/firebase_error_mapper.dart';
import '../../domain/entities/support_query.dart';
import '../../domain/repositories/support_repository.dart';
import '../datasources/support_remote_datasource.dart';

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource _remote;
  SupportRepositoryImpl(this._remote);

  @override
  Future<void> submitQuery(SupportQuery query) =>
      _guard(() => _remote.submit(query));

  @override
  Future<void> markResolved(String id) =>
      _guard(() => _remote.markResolved(id));

  @override
  Future<void> deleteQuery(String id) => _guard(() => _remote.delete(id));

  @override
  Stream<List<SupportQuery>> watchQueries() => _mapErrors(_remote.watchQueries());

  @override
  Stream<int> watchPendingCount() => _mapErrors(_remote.watchPendingCount());

  Stream<T> _mapErrors<T>(Stream<T> source) => source.transform(
        StreamTransformer<T, T>.fromHandlers(
          handleData: (data, sink) => sink.add(data),
          handleError: (error, stack, sink) => sink.addError(
            error is FirebaseException ? mapFirebaseException(error) : error,
            stack,
          ),
        ),
      );

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}