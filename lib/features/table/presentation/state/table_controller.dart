import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/table/presentation/state/table_state.dart';
//import 'package:treesense/features/table/infrastructure/services/table_service.dart';
import 'package:treesense/features/table/infrastructure/models/tree_row_mapper.dart';
//import 'package:treesense/features/table/presentation/state/table_provider.dart';
import 'package:treesense/features/tree/infrastructure/models/paginated_trees.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class TableController extends StateNotifier<TableState> {
  final TreeRepository _repo;

  TableController(this._repo) : super(const TableState());

  Future<void> loadPage({required int offset, required int limit}) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final PaginatedTrees page = await _repo.listAll(
        offset: offset,
        limit: limit,
      );

      final vms = page.items.map(TreeRowMapper.fromDomain).toList();

      state = state.copyWith(
        rows: vms,
        offset: offset,
        limit: limit,
        total: page.total,
        loading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
