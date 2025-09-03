import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_layout.dart';
import 'package:treesense/core/theme/font_conf.dart';

//TODO: ver de hacer un selector de theme
class TableTheme {
  static ThemeData light(
    BuildContext context, {
    Color? headingBg, // header background colour
    Color? tableBg, // row background colour
    Color? dividerColor,
  }) {
    final base = Theme.of(context);
    return base.copyWith(
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(headingBg ?? columnTitleColor),
        headingTextStyle: AppTextStyles.columnTitleTextStyle.copyWith(
          color: Colors.white,
        ),
        dataTextStyle: AppTextStyles.rowDataTextStyle,
        dataRowMinHeight: TableConstants.rowH,
        dataRowMaxHeight: TableConstants.rowH,
        dataRowColor: WidgetStateProperty.all(tableBg ?? tableColor),
        dividerThickness: 2.5,
      ),
      dividerColor: dividerColor ?? Colors.black26,
    );
  }

  static ThemeData dark(
    BuildContext context, {
    Color? headingBg,
    Color? tableBg,
    Color? dividerColor,
  }) {
    final base = Theme.of(context);
    final scheme = base.colorScheme;

    final heading = headingBg ?? scheme.primary;
    final table =
        tableBg ?? scheme.surfaceContainerHighest.withValues(alpha: 0.20);

    return base.copyWith(
      brightness: Brightness.dark,
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(heading),
        headingTextStyle: AppTextStyles.columnTitleTextStyle.copyWith(
          color: Colors.white,
        ),
        dataTextStyle: AppTextStyles.rowDataTextStyle.copyWith(
          color: scheme.onSurface,
        ),
        dataRowMinHeight: TableConstants.rowH,
        dataRowMaxHeight: TableConstants.rowH,
        dataRowColor: WidgetStateProperty.all(table),
        dividerThickness: 2.0,
      ),
      dividerColor: dividerColor ?? Colors.white12,
    );
  }

  /// Helper: elige automáticamente según brightness actual,
  /// con override opcional por parámetro.
  static ThemeData resolve(
    BuildContext context, {
    bool? forceDark, // null → autodetect
    Color? headingBg,
    Color? tableBg,
    Color? dividerColor,
  }) {
    final isDark = forceDark ?? Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? dark(
          context,
          headingBg: headingBg,
          tableBg: tableBg,
          dividerColor: dividerColor,
        )
        : light(
          context,
          headingBg: headingBg,
          tableBg: tableBg,
          dividerColor: dividerColor,
        );
  }
}
