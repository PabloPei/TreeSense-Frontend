import 'dart:math' as math;
import 'package:flutter/material.dart';

class TableConstants {
  static const headingH = 56.0;
  static const footerH = 64.0;
  static const rowH = 52.0;
  static const minColW = 140.0;
}

class TableLayout {
  final double tableWidth;
  final double tableHeight;
  final List<int> rowsOptions;
  final int effectiveRowsPerPage;

  const TableLayout({
    required this.tableWidth,
    required this.tableHeight,
    required this.rowsOptions,
    required this.effectiveRowsPerPage,
  });
}

typedef TableLayoutWidgetBuilder =
    Widget Function(BuildContext context, TableLayout layout);

/// Calcula width/height exactos para el PaginatedDataTable y entrega opciones
/// de "rows per page" válidas en base a los constraints del padre.
class TreesTableLayoutBuilder extends StatelessWidget {
  final int columnsCount;
  final int currentRowsPerPage;
  final TableLayoutWidgetBuilder builder;

  const TreesTableLayoutBuilder({
    super.key,
    required this.columnsCount,
    required this.currentRowsPerPage,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // Ancho: forzamos scroll horizontal real
        final tableWidth = math.max(
          c.maxWidth,
          columnsCount * TableConstants.minColW,
        );

        // Alto disponible: si el padre no da altura finita, usamos alto de pantalla
        final double viewportH =
            c.hasBoundedHeight
                ? c.maxHeight
                : MediaQuery.sizeOf(context).height;

        // Filas que realmente entran (redondeo hacia abajo, mínimo 1)
        final maxRowsFit = math.max(
          1,
          ((viewportH - TableConstants.headingH - TableConstants.footerH) /
                  TableConstants.rowH)
              .floor(),
        );

        // Opciones “seguras”
        final baseOptions = const [10, 25, 50, 100];
        final filtered = baseOptions.where((n) => n <= maxRowsFit).toList();
        final rowsOptions = filtered.isNotEmpty ? filtered : [10, 25];

        // Ajustar el valor actual al rango disponible
        final effectiveRowsPerPage = currentRowsPerPage.clamp(
          rowsOptions.first,
          rowsOptions.last,
        );

        final tableHeight =
            TableConstants.headingH +
            TableConstants.footerH +
            (TableConstants.rowH * effectiveRowsPerPage);

        return builder(
          context,
          TableLayout(
            tableWidth: tableWidth,
            tableHeight: tableHeight,
            rowsOptions: rowsOptions,
            effectiveRowsPerPage: effectiveRowsPerPage,
          ),
        );
      },
    );
  }
}
