import 'package:treesense/features/table/infrastructure/models/view_models/tree_row_vm.dart';

class TableState {
  final List<TreeRowVM> rows;
  final int offset;
  final int limit;
  final int total;
  final bool loading;
  final String? error;

  const TableState({
    this.rows = const [],
    this.offset = 0,
    this.limit = 25,
    this.total = 0,
    this.loading = false,
    this.error,
  });

  TableState copyWith({
    List<TreeRowVM>? rows,
    int? offset,
    int? limit,
    int? total,
    bool? loading,
    String? error,
  }) {
    return TableState(
      rows: rows ?? this.rows,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
