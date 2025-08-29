import 'package:flutter/material.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/app_theme.dart';

//TODO: poner lindo, hacer macros de fuentes, etc.
class ExportButton extends StatelessWidget {
  final double width;
  final double fontSize;

  const ExportButton({super.key, required this.width, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          // TODO: implementar exportación a CSV/XLSX
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primarySeedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.xl),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
        ),
        child: FittedBox(
          child: Text(
            MessageLoader.get('export'),
            style: AppTextStyles.bottomTextStyle.copyWith(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
