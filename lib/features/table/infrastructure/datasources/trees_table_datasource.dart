import 'package:flutter/material.dart';
import 'package:treesense/features/table/presentation/widgets/view_models/tree_row_vm.dart';
import 'package:treesense/core/theme/font_conf.dart';

class TreesDataSource extends DataTableSource {
  final List<TreeRowVM> _rows;
  final void Function(String message) onShowMessage;
  final void Function(TreeRowVM row, TapDownDetails details) onIdTapDown;

  int? _hoveredIndex; // hover en celda ID

  TreesDataSource(
    this._rows, {
    required this.onShowMessage,
    required this.onIdTapDown,
  });

  void sort<T>(Comparable<T> Function(TreeRowVM d) getField, bool ascending) {
    _rows.sort((a, b) {
      final aKey = getField(a);
      final bKey = getField(b);
      final comp = Comparable.compare(aKey, bKey);
      return ascending ? comp : -comp;
    });
    notifyListeners();
  }

  void _setHover(int? index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _rows.length) return null;
    final r = _rows[index];
    final hovered = _hoveredIndex == index;

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Center(
            child: MouseRegion(
              onEnter: (_) => _setHover(index),
              onExit: (_) => _setHover(null),
              child: InkWell(
                onTap: () {},
                onTapDown: (details) => onIdTapDown(r, details),
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: hovered ? Colors.black12 : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow:
                        hovered
                            ? [
                              BoxShadow(
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                                color: Colors.black.withOpacity(0.08),
                              ),
                            ]
                            : null,
                  ),
                  child: Text(r.idShort, style: AppTextStyles.rowDataTextStyle),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(r.typeId ?? '', style: AppTextStyles.rowDataTextStyle),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              r.speciesName ?? '',
              style: AppTextStyles.rowDataTextStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(r.heightDisplay, style: AppTextStyles.rowDataTextStyle),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              r.canopyDiameterDisplay,
              style: AppTextStyles.rowDataTextStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              r.districtName ?? '',
              style: AppTextStyles.rowDataTextStyle,
            ),
          ),
        ),
        DataCell(
          Center(child: Icon(r.isRootIssuePresent ? Icons.check : Icons.close)),
        ),
        DataCell(
          Center(
            child: Icon(r.isBranchIssuePresent ? Icons.check : Icons.close),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              r.listsCommaSeparated,
              style: AppTextStyles.rowDataTextStyle,
            ),
          ),
        ),
        DataCell(
          Center(
            child: TextButton.icon(
              onPressed: () => onShowMessage('Visor de fotos no implementado'),
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(
                '${r.photosCount}',
                style: AppTextStyles.rowDataTextStyle,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              r.createdAtShort,
              style: AppTextStyles.rowDataTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _rows.length;
  @override
  int get selectedRowCount => 0;
}
