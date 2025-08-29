import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/table/presentation/widgets/table_parts/centered_header.dart';
import 'package:treesense/features/table/presentation/widgets/table_parts/mini_actions_popover.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/table/infrastructure/datasources/trees_table_datasource.dart';
import 'package:treesense/features/table/presentation/widgets/view_models/tree_row_vm.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey _stackKey = GlobalKey(); // para ubicar el popover
  final ScrollController _hController = ScrollController();

  late TreesDataSource _dataSource;
  int _rowsPerPage = 25;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  TreeRowVM? _selected;
  Offset? _anchor; // posición donde clickeaste el ID

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

    // Cerrar popover al scrollear horizontalmente
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth =
            constraints.maxWidth >= 1200 ? constraints.maxWidth : 1200;

        // Cálculo para no desbordar verticalmente
        const double kHeading = 56, kFooter = 64, kRow = 52, kPadding = 24;
        final double availableH =
            constraints.maxHeight - kHeading - kFooter - kPadding;
        final int maxRowsThatFit =
            availableH.isFinite ? availableH ~/ kRow : _rowsPerPage;

        final allowed =
            [10, 25, 50, 100]
                .where((n) => n <= (maxRowsThatFit > 0 ? maxRowsThatFit : 10))
                .toList();
        final availableRowsPerPage = allowed.isNotEmpty ? allowed : [10];
        final effectiveRowsPerPage = _rowsPerPage.clamp(
          availableRowsPerPage.first,
          availableRowsPerPage.last,
        );

        return Theme(
          data: Theme.of(context).copyWith(
            dataTableTheme: DataTableThemeData(
              // Fondo de la fila de encabezado
              headingRowColor: MaterialStateProperty.all(columnTitleColor),
              // Texto de encabezado en blanco (legible sobre el fondo)
              headingTextStyle: AppTextStyles.columnTitleTextStyle.copyWith(
                color: Colors.white,
              ),
              dataTextStyle: AppTextStyles.rowDataTextStyle,
              dataRowColor: MaterialStateProperty.all(tableColor),
              dividerThickness: 2.5,
            ),
            dividerColor: Colors.black26,
          ),
          child: Stack(
            key:
                _stackKey, // clave para posicionar el popover respecto al Stack
            children: [
              // Tabla con scroll horizontal
              Scrollbar(
                controller: _hController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _hController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: PaginatedDataTable(
                      showCheckboxColumn: false,
                      rowsPerPage: effectiveRowsPerPage,
                      availableRowsPerPage: availableRowsPerPage,
                      onRowsPerPageChanged: (v) {
                        if (v != null) setState(() => _rowsPerPage = v);
                      },
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: [
                        DataColumn(
                          label: CenteredHeader(
                            'ID',
                            isSorted: _sortColumnIndex == 0,
                          ),
                          onSort:
                              (i, asc) => _sort<String>((d) => d.id, i, asc),
                        ),
                        DataColumn(
                          label: CenteredHeader(
                            'Tipo',
                            isSorted: _sortColumnIndex == 1,
                          ),
                          onSort:
                              (i, asc) =>
                                  _sort<String>((d) => d.typeId ?? '', i, asc),
                        ),
                        DataColumn(
                          label: CenteredHeader(
                            'Especie',
                            isSorted: _sortColumnIndex == 2,
                          ),
                          onSort:
                              (i, asc) => _sort<String>(
                                (d) => d.speciesName ?? '',
                                i,
                                asc,
                              ),
                        ),
                        DataColumn(
                          label: CenteredHeader(
                            'Altura (m)',
                            isSorted: _sortColumnIndex == 3,
                          ),
                          onSort:
                              (i, asc) => _sort<num>(
                                (d) => _parseNum(d.heightDisplay),
                                i,
                                asc,
                              ),
                        ),
                        DataColumn(
                          label: CenteredHeader(
                            'Diám. copa (m)',
                            isSorted: _sortColumnIndex == 4,
                          ),
                          onSort:
                              (i, asc) => _sort<num>(
                                (d) => _parseNum(d.canopyDiameterDisplay),
                                i,
                                asc,
                              ),
                        ),
                        DataColumn(
                          label: CenteredHeader(
                            'Barrio',
                            isSorted: _sortColumnIndex == 5,
                          ),
                          onSort:
                              (i, asc) => _sort<String>(
                                (d) => d.districtName ?? '',
                                i,
                                asc,
                              ),
                        ),
                        const DataColumn(label: CenteredHeader('Raíces?')),
                        const DataColumn(label: CenteredHeader('Ramas?')),
                        const DataColumn(label: CenteredHeader('Listas')),
                        const DataColumn(label: CenteredHeader('Fotos')),
                        const DataColumn(label: CenteredHeader('Creado')),
                      ],
                      source: _dataSource,
                    ),
                  ),
                ),
              ),

              // Capa para cerrar al click fuera (por encima de la tabla)
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

              // Popover chico junto al ID (solo Editar/Borrar/Cerrar)
              if (_selected != null && _anchor != null)
                Positioned(
                  // un poco a la derecha/abajo del click
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
      },
    );
  }

  static num _parseNum(String s) {
    if (s.isEmpty) return -1;
    return num.tryParse(s) ?? -1;
  }
}
