import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/table/presentation/widgets/export_button.dart';
import 'package:treesense/features/table/presentation/widgets/trees_table.dart';
import 'package:treesense/features/table/presentation/state/table_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final userPhoto = userState.user?.photo;

    final tableState = ref.watch(tableControllerProvider);
    final tableCtl = ref.read(tableControllerProvider.notifier);

    // First load is automatic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tableState.rows.isEmpty &&
          !tableState.loading &&
          tableState.error == null) {
        tableCtl.loadPage(offset: 0, limit: tableState.limit);
      }
    });

    final userPhotoDiameter = context.screenWidth * 0.08;
    final formButtonWidth = context.screenWidth * 0.08;
    final fontSize = formButtonWidth * 0.01;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: userPhotoDiameter,
                      height: userPhotoDiameter,
                      child: GestureDetector(
                        onTap: () => context.push('/profile'),
                        child: Tooltip(
                          message: MessageLoader.get('see_profile'),
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: UserProfilePhoto(
                              photo: userPhoto,
                              radius: userPhotoDiameter / 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: ExportButton(
                          width: formButtonWidth,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // ===== Main content =====
                Expanded(
                  child: Stack(
                    children: [
                      // Server-side paginated table
                      TreesTable(
                        rows: tableState.rows,
                        offset: tableState.offset,
                        total: tableState.total,
                        rowsPerPage: tableState.limit,
                        onRowsPerPageChanged: (v) {
                          tableCtl.loadPage(offset: 0, limit: v);
                        },
                        onPageChanged: (firstRowIndex) {
                          tableCtl.loadPage(
                            offset: firstRowIndex,
                            limit: tableState.limit,
                          );
                        },
                      ),

                      // Loading when there is no data available
                      if (tableState.loading && tableState.rows.isNotEmpty)
                        const Positioned.fill(
                          child: ColoredBox(
                            color: Colors.black26,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),

                      // Initial state
                      if (tableState.loading && tableState.rows.isEmpty)
                        const Center(child: CircularProgressIndicator()),

                      // Error no data
                      if (tableState.error != null && tableState.rows.isEmpty)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Error: ${tableState.error}',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              FilledButton(
                                onPressed: () {
                                  tableCtl.loadPage(
                                    offset: 0,
                                    limit: tableState.limit,
                                  );
                                },
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
