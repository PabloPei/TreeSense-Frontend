import 'package:flutter/material.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/features/table/infrastructure/models/view_models/tree_row_vm.dart';

typedef OnIdTapDown = void Function(TreeRowVM row, TapDownDetails details);
typedef OnShowMessage = void Function(String message);
typedef OnHoverEnter = void Function(int index);
typedef OnHoverExit = void Function();

class TreesRowCellsBuilder {
  static List<DataCell> build({
    required TreeRowVM row,
    required int index,
    required bool hovered,
    required OnIdTapDown onIdTapDown,
    required OnShowMessage onShowMessage,
    required OnHoverEnter onHoverEnter,
    required OnHoverExit onHoverExit,
  }) {
    return [
      DataCell(
        Center(
          child: MouseRegion(
            onEnter: (_) => onHoverEnter(index),
            onExit: (_) => onHoverExit(),
            child: InkWell(
              onTap: () {},
              onTapDown: (details) => onIdTapDown(row, details),
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: hovered ? Colors.black12 : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:
                      hovered
                          ? [
                            BoxShadow(
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                              color: Colors.black.withValues(alpha: 0.08),
                            ),
                          ]
                          : null,
                ),
                child: Text(row.idShort, style: AppTextStyles.rowDataTextStyle),
              ),
            ),
          ),
        ),
      ),

      DataCell(
        Center(
          child: Text(row.typeId ?? '', style: AppTextStyles.rowDataTextStyle),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            row.speciesName ?? '',
            style: AppTextStyles.rowDataTextStyle,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(row.heightDisplay, style: AppTextStyles.rowDataTextStyle),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            row.canopyDiameterDisplay,
            style: AppTextStyles.rowDataTextStyle,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            row.districtName ?? '',
            style: AppTextStyles.rowDataTextStyle,
          ),
        ),
      ),
      DataCell(
        Center(child: Icon(row.isRootIssuePresent ? Icons.check : Icons.close)),
      ),
      DataCell(
        Center(
          child: Icon(row.isBranchIssuePresent ? Icons.check : Icons.close),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            row.listsCommaSeparated,
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
              '${row.photosCount}',
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
            row.createdAtShort,
            style: AppTextStyles.rowDataTextStyle,
          ),
        ),
      ),
    ];
  }
}
