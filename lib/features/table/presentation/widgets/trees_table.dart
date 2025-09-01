import 'package:flutter/material.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/mini_actions_popover.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_layout.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/trees_columns.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_theme.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/table/infrastructure/datasources/trees_table_datasource.dart';
import 'package:treesense/features/table/presentation/widgets/view_models/tree_row_vm.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';

class TreesTable extends StatefulWidget {
  final List<TreeRowVM> rows;
  final int initialRowsPerPage;

  const TreesTable({
    super.key,
    required this.rows,
    this.initialRowsPerPage = 25,
  });

  factory TreesTable.sample({int count = 200, int initialRowsPerPage = 25}) {
    return TreesTable(
      rows: TreeRowVM.sample(count),
      initialRowsPerPage: initialRowsPerPage,
    );
  }

  @override
  State<TreesTable> createState() => _TreesTableState();
}

class _TreesTableState extends State<TreesTable> {
  final GlobalKey _stackKey = GlobalKey();
  final ScrollController _hController = ScrollController();

  late TreesDataSource _dataSource;
  int _rowsPerPage = 25;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  TreeRowVM? _selected;
  Offset? _anchor;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initialRowsPerPage;

    _dataSource = TreesDataSource(
      widget.rows,
      onShowMessage: _showMessage,
      onIdTapDown: (row, details) {
        final box = _stackKey.currentContext!.findRenderObject() as RenderBox;
        final local = box.globalToLocal(details.globalPosition);
        setState(() {
          _selected = row;
          _anchor = local;
        });
      },
    );

    _hController.addListener(() {
      if (_selected != null || _anchor != null) {
        setState(() {
          _selected = null;
          _anchor = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _hController.dispose();
    super.dispose();
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _sort<T>(
    Comparable<T> Function(TreeRowVM d) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _dataSource.sort<T>(getField, ascending);
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = TreesColumns.build(
      sortColumnIndex: _sortColumnIndex,
      sort: _sort,
    );

    return Theme(
      data: TableTheme.resolve(context),
      child: Stack(
        key: _stackKey,
        children: [
          TreesTableLayoutBuilder(
            columnsCount: columns.length,
            currentRowsPerPage: _rowsPerPage,
            builder: (context, layout) {
              return Scrollbar(
                controller: _hController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _hController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: layout.tableWidth,
                    height: layout.tableHeight,
                    child: PaginatedDataTable(
                      showCheckboxColumn: false,
                      rowsPerPage: layout.effectiveRowsPerPage,
                      availableRowsPerPage: layout.rowsOptions,
                      onRowsPerPageChanged: (v) {
                        if (v != null) setState(() => _rowsPerPage = v);
                      },
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: columns,
                      source: _dataSource,
                    ),
                  ),
                ),
              );
            },
          ),

          // popover
          if (_selected != null && _anchor != null)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap:
                    () => setState(() {
                      _selected = null;
                      _anchor = null;
                    }),
              ),
            ),

          if (_selected != null && _anchor != null)
            Positioned(
              left: _anchor!.dx + 8,
              top: _anchor!.dy + 8,
              child: MiniActionsPopover(
                onEdit: () {
                  _showMessage('Editar ${_selected!.idShort}');
                  setState(() {
                    _selected = null;
                    _anchor = null;
                  });
                },
                onDelete: () {
                  _showMessage('Borrar ${_selected!.idShort}');
                  setState(() {
                    _selected = null;
                    _anchor = null;
                  });
                },
                onClose:
                    () => setState(() {
                      _selected = null;
                      _anchor = null;
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
