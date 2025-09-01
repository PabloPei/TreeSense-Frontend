import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/table/presentation/widgets/table_config/table_layout.dart';
import 'package:treesense/core/theme/font_conf.dart';

//TODO: ver de hacer un selector de theme
class TableTheme {
  /// Tema claro (light). Usa tus colores por defecto si están disponibles.
  static ThemeData light(
    BuildContext context, {
    Color? headingBg, // fondo del header
    Color? tableBg, // fondo de filas
    Color? dividerColor,
  }) {
    final base = Theme.of(context);
    return base.copyWith(
      dataTableTheme: DataTableThemeData(
        headingRowColor: MaterialStateProperty.all(
          headingBg ?? columnTitleColor, // tu color existente
        ),
        headingTextStyle: AppTextStyles.columnTitleTextStyle.copyWith(
          color: Colors.white,
        ),
        dataTextStyle: AppTextStyles.rowDataTextStyle,
        dataRowMinHeight: TableConstants.rowH,
        dataRowMaxHeight: TableConstants.rowH,
        dataRowColor: MaterialStateProperty.all(
          tableBg ?? tableColor, // tu color existente para filas
        ),
        dividerThickness: 2.5,
      ),
      dividerColor: dividerColor ?? Colors.black26,
      // No cambiamos brightness aquí; respetamos el tema global.
    );
  }

  /// Tema oscuro (dark). Asegura buen contraste.
  static ThemeData dark(
    BuildContext context, {
    Color? headingBg,
    Color? tableBg,
    Color? dividerColor,
  }) {
    final base = Theme.of(context);
    final scheme = base.colorScheme;

    // Defaults “seguros” en dark: header con primary, filas con surfaceVariant translúcido.
    final _heading = headingBg ?? scheme.primary;
    final _table = tableBg ?? scheme.surfaceVariant.withOpacity(0.20);

    return base.copyWith(
      brightness: Brightness.dark,
      dataTableTheme: DataTableThemeData(
        headingRowColor: MaterialStateProperty.all(_heading),
        headingTextStyle: AppTextStyles.columnTitleTextStyle.copyWith(
          color: Colors.white,
        ),
        dataTextStyle: AppTextStyles.rowDataTextStyle.copyWith(
          color: scheme.onSurface, // asegura contraste en dark
        ),
        dataRowMinHeight: TableConstants.rowH,
        dataRowMaxHeight: TableConstants.rowH,
        dataRowColor: MaterialStateProperty.all(_table),
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
