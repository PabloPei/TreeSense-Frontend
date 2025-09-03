import 'dart:math' as math;
import 'package:flutter/material.dart';

class TableConstants {
  static const headingH = 56.0;
  static const footerH = 64.0;
  static const rowH = 52.0;
  static const minColW = 160.0;
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
        // ====== WIDTH ======
        // Si el padre no tiene ancho acotado, usamos el ancho de pantalla.
        final double viewportW =
            c.hasBoundedWidth ? c.maxWidth : MediaQuery.sizeOf(context).width;

        final double minNeededWidth = columnsCount * TableConstants.minColW;

        // Forzamos que la tabla pueda ser más ancha que el viewport → habilita scroll X
        final double tableWidth = math.max(viewportW, minNeededWidth);

        // ====== HEIGHT ======
        // Si el padre no tiene altura acotada, usamos alto de pantalla.
        final double viewportH =
            c.hasBoundedHeight
                ? c.maxHeight
                : MediaQuery.sizeOf(context).height;

        // Filas que realmente entran (redondeo hacia abajo, mínimo 1)
        final int maxRowsFit = math.max(
          1,
          ((viewportH - TableConstants.headingH - TableConstants.footerH) /
                  TableConstants.rowH)
              .floor(),
        );

        // ====== ROWS PER PAGE OPTIONS ======
        // Opciones base y filtrado por lo que entra en el viewport.
        const baseOptions = [10, 25, 50, 100];
        List<int> rowsOptions =
            baseOptions.where((n) => n <= maxRowsFit).toList();

        // Si ninguna base entra, al menos ofrecemos [maxRowsFit] (p.ej., 1..9).
        if (rowsOptions.isEmpty) {
          rowsOptions = [maxRowsFit];
        }

        // Si el valor actual no está en las opciones pero entra, lo agregamos y ordenamos.
        if (currentRowsPerPage <= maxRowsFit &&
            !rowsOptions.contains(currentRowsPerPage)) {
          rowsOptions = [...rowsOptions, currentRowsPerPage]..sort();
        }

        // Valor efectivo dentro del rango disponible
        final int effectiveRowsPerPage = currentRowsPerPage.clamp(
          rowsOptions.first,
          rowsOptions.last,
        );

        // Altura exacta de la tabla: header + footer + filas visibles
        final double tableHeight =
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
