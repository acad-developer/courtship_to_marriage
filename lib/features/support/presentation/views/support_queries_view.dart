import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../admin/presentation/widgets/admin_header.dart';
import '../controllers/support_queries_controller.dart';
import '../widgets/support_query_card.dart';

class SupportQueriesView extends GetView<SupportQueriesController> {
  const SupportQueriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AdminHeader(title: 'Support Queries'),
          Obx(() => Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: Row(
              children: [
                _TabChip(
                  label: 'Pending (${controller.pendingCount})',
                  selected: !controller.showResolved.value,
                  onTap: () => controller.showResolved.value = false,
                ),
                const SizedBox(width: 10),
                _TabChip(
                  label: 'Resolved (${controller.resolvedCount})',
                  selected: controller.showResolved.value,
                  onTap: () => controller.showResolved.value = true,
                ),
              ],
            ),
          )),
          const Divider(height: 1, color: AppColors.border),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              final error = controller.errorMessage.value;
              if (error != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(error,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColors.textSecondary)),
                        TextButton(
                          onPressed: controller.retry,
                          child: const Text('Retry',
                              style: TextStyle(color: AppColors.primary)),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final list = controller.visible;
              if (list.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryLight),
                          child: const Icon(Icons.support_agent_rounded,
                              size: 36, color: AppColors.primary),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          controller.showResolved.value
                              ? 'No resolved queries'
                              : 'All caught up',
                          style: AppTextStyles.heading(22),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.showResolved.value
                              ? 'Resolved queries will appear here.'
                              : 'There are no pending queries right now.',
                          textAlign: TextAlign.center,
                          style:
                          const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final query = list[i];
                  return Obx(() => SupportQueryCard(
                    query: query,
                    isBusy: controller.busyId.value == query.id,
                    onResolve: () => controller.resolve(query),
                    onDelete: () => controller.confirmDelete(query),
                    onCall: () => controller.callUser(query),
                    onWhatsapp: () => controller.whatsappUser(query),
                    onEmail: () => controller.emailUser(query),
                  ));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}