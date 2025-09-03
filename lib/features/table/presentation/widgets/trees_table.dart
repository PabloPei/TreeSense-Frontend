import 'package:flutter/material.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/mini_actions_popover.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_layout.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/trees_columns.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_theme.dart';
import 'package:treesense/features/table/infrastructure/datasources/trees_table_datasource.dart';
import 'package:treesense/features/table/infrastructure/models/view_models/tree_row_vm.dart';

import 'dart:ui' show PointerDeviceKind;

class TreesTable extends StatefulWidget {
  final List<TreeRowVM> rows;
  final int offset;
  final int total;
  final int rowsPerPage;

  // callbacks para paginación server-side
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<int> onPageChanged;

  const TreesTable({
    super.key,
    required this.rows,
    required this.offset,
    required this.total,
    required this.rowsPerPage,
    required this.onRowsPerPageChanged,
    required this.onPageChanged,
  });

  @override
  State<TreesTable> createState() => _TreesTableState();
}

class _TreesTableState extends State<TreesTable> {
  final GlobalKey _stackKey = GlobalKey();
  final ScrollController _hController = ScrollController();

  late TreesDataSource _dataSource;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  TreeRowVM? _selected;
  Offset? _anchor;

  @override
  void initState() {
    super.initState();

    _dataSource = TreesDataSource(
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
  void didUpdateWidget(covariant TreesTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _dataSource.updateFromState(
      rows: widget.rows,
      offset: widget.offset,
      total: widget.total,
    );
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
      _dataSource.sort<T>(
        getField,
        ascending,
      ); //TODO: cambiar con el sort server-side
    });
  }

  @override
  Widget build(BuildContext context) {
    _dataSource.updateFromState(
      rows: widget.rows,
      offset: widget.offset,
      total: widget.total,
    );

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
            currentRowsPerPage: widget.rowsPerPage,
            builder: (context, layout) {
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.stylus,
                  },
                ),
                child: Scrollbar(
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

                        // paginación server-side
                        rowsPerPage: layout.effectiveRowsPerPage,
                        availableRowsPerPage: layout.rowsOptions,
                        onRowsPerPageChanged: (v) {
                          if (v != null) widget.onRowsPerPageChanged(v);
                        },
                        onPageChanged: (firstRowIndex) {
                          widget.onPageChanged(firstRowIndex);
                        },

                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: columns,

                        source: _dataSource,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // close the popover
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
