import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/table/infrastructure/services/table_service.dart';
import 'package:treesense/features/tree/presentation/state/tree_provider.dart';
import 'package:treesense/features/table/presentation/state/table_state.dart';
import 'package:treesense/features/table/presentation/state/table_controller.dart';

final tableServiceProvider = Provider<TableService>((ref) {
  final uc = ref.read(getAllTreesPaginatedUseCaseProvider);
  return TableService(uc);
});

final tableControllerProvider =
    StateNotifierProvider<TableController, TableState>((ref) {
      final repo = ref.read(treeRepositoryProvider);
      return TableController(repo);
    });
