import 'package:flutter/material.dart';
import 'package:treesense/features/table/infrastructure/models/view_models/tree_row_vm.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/tree_row_cells_builder.dart';

class TreesDataSource extends DataTableSource {
  final void Function(String message) onShowMessage;
  final void Function(TreeRowVM row, TapDownDetails details) onIdTapDown;

  List<TreeRowVM> _pageRows = const [];
  int _offset = 0;
  int _total = 0;

  int? _hoveredGlobalIndex;

  TreesDataSource({required this.onShowMessage, required this.onIdTapDown});

  /// Sincronize page with the controller
  void updateFromState({
    required List<TreeRowVM> rows,
    required int offset,
    required int total,
  }) {
    _pageRows = rows;
    _offset = offset;
    _total = total;

    if (_hoveredGlobalIndex != null) {
      final start = _offset;
      final end = _offset + _pageRows.length - 1;
      if (_hoveredGlobalIndex! < start || _hoveredGlobalIndex! > end) {
        _hoveredGlobalIndex = null;
      }
    }
    notifyListeners();
  }

  /// TODO: reemplazar por un fetch y hacer el sort server-side
  void sort<T>(Comparable<T> Function(TreeRowVM d) getField, bool ascending) {
    _pageRows.sort((a, b) {
      final aKey = getField(a);
      final bKey = getField(b);
      final comp = Comparable.compare(aKey, bKey);
      return ascending ? comp : -comp;
    });
    notifyListeners();
  }

  void _setHover(int? globalIndex) {
    _hoveredGlobalIndex = globalIndex;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final local = index - _offset;
    if (local < 0 || local >= _pageRows.length) return null;

    final row = _pageRows[local];
    final hovered = _hoveredGlobalIndex == index;

    final cells = TreesRowCellsBuilder.build(
      row: row,
      index: index, // GLOBAL
      hovered: hovered,
      onIdTapDown: onIdTapDown,
      onShowMessage: onShowMessage,
      onHoverEnter: (i) => _setHover(i), // global
      onHoverExit: () => _setHover(null),
    );

    return DataRow.byIndex(index: index, cells: cells);
  }

  @override
  int get rowCount => _total;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
