import 'package:flutter/material.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/centered_header.dart';
import 'package:treesense/features/table/presentation/widgets/view_models/tree_row_vm.dart';

typedef SortCallback =
    void Function<T>(
      Comparable<T> Function(TreeRowVM d) getField,
      int columnIndex,
      bool ascending,
    );

class TreesColumns {
  static List<DataColumn> build({
    required int? sortColumnIndex,
    required SortCallback sort, // 👈 ahora es la función genérica
  }) {
    return <DataColumn>[
      DataColumn(
        label: CenteredHeader('ID', isSorted: sortColumnIndex == 0),
        onSort: (i, asc) => sort<String>((d) => d.id, i, asc),
      ),
      DataColumn(
        label: CenteredHeader('Tipo', isSorted: sortColumnIndex == 1),
        onSort: (i, asc) => sort<String>((d) => d.typeId ?? '', i, asc),
      ),
      DataColumn(
        label: CenteredHeader('Especie', isSorted: sortColumnIndex == 2),
        onSort: (i, asc) => sort<String>((d) => d.speciesName ?? '', i, asc),
      ),
      DataColumn(
        label: CenteredHeader('Altura (m)', isSorted: sortColumnIndex == 3),
        onSort:
            (i, asc) => sort<num>((d) => _parseNum(d.heightDisplay), i, asc),
      ),
      DataColumn(
        label: CenteredHeader('Diám. copa (m)', isSorted: sortColumnIndex == 4),
        onSort:
            (i, asc) =>
                sort<num>((d) => _parseNum(d.canopyDiameterDisplay), i, asc),
      ),
      DataColumn(
        label: CenteredHeader('Barrio', isSorted: sortColumnIndex == 5),
        onSort: (i, asc) => sort<String>((d) => d.districtName ?? '', i, asc),
      ),
      const DataColumn(label: CenteredHeader('Raíces?')),
      const DataColumn(label: CenteredHeader('Ramas?')),
      const DataColumn(label: CenteredHeader('Listas')),
      const DataColumn(label: CenteredHeader('Fotos')),
      const DataColumn(label: CenteredHeader('Creado')),
    ];
  }

  static num _parseNum(String s) => s.isEmpty ? -1 : (num.tryParse(s) ?? -1);
}
