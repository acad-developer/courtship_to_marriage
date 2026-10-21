import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/app_snackbar.dart';
import '../../../../core/utils/contact_actions.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../domain/entities/support_query.dart';
import '../../domain/usecases/support_usecases.dart';

class SupportQueriesController extends GetxController {
  final WatchSupportQueriesUseCase _watchQueries;
  final ResolveSupportQueryUseCase _resolveQuery;
  final DeleteSupportQueryUseCase _deleteQuery;

  SupportQueriesController(
      this._watchQueries,
      this._resolveQuery,
      this._deleteQuery,
      );

  final queries = <SupportQuery>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final showResolved = false.obs; // false = Pending tab
  final busyId = RxnString();

  StreamSubscription<List<SupportQuery>>? _subscription;

  int get pendingCount => queries.where((q) => !q.isResolved).length;
  int get resolvedCount => queries.where((q) => q.isResolved).length;

  List<SupportQuery> get visible =>
      queries.where((q) => q.isResolved == showResolved.value).toList();

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading.value = true;
    errorMessage.value = null;
    _subscription?.cancel();
    _subscription = _watchQueries().listen(
          (list) {
        queries.assignAll(list);
        isLoading.value = false;
      },
      onError: (Object e) {
        errorMessage.value =
        e is AppException ? e.message : 'Could not load the queries.';
        isLoading.value = false;
      },
    );
  }

  void retry() => _listen();

  Future<void> resolve(SupportQuery query) async {
    if (busyId.value != null) return;
    busyId.value = query.id;
    try {
      await _resolveQuery(query.id);
      AppSnackbar.success('Marked as resolved.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      busyId.value = null;
    }
  }

  Future<void> confirmDelete(SupportQuery query) async {
    if (busyId.value != null) return;
    final confirmed = await Get.dialog<bool>(
      const ConfirmDialog(
        title: 'Delete this query?',
        message: 'This resolved query will be permanently deleted.',
        confirmLabel: 'Delete',
        icon: Icons.delete_outline_rounded,
      ),
    ) ??
        false;
    if (!confirmed) return;

    busyId.value = query.id;
    try {
      await _deleteQuery(query);
      AppSnackbar.success('Query deleted.');
    } on AppException catch (e) {
      AppSnackbar.error(e.message);
    } finally {
      busyId.value = null;
    }
  }

  // Reply to the user.
  void callUser(SupportQuery q) => ContactActions.call(q.phone);

  void whatsappUser(SupportQuery q) => ContactActions.whatsapp(
    q.phone,
    message: 'Hello ${q.name}, regarding your query "${q.subject}": ',
  );

  void emailUser(SupportQuery q) =>
      ContactActions.email(q.email, subject: 'Re: ${q.subject}');

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}