import 'package:flutter/material.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/app_theme.dart';

class UserLanguageWidget extends StatelessWidget {
  final String language;

  const UserLanguageWidget({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.language,
          size: AppIconSizes.profile,
          color: profileDetailsColor,
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MessageLoader.get('language'),
              style: AppTextStyles.userLabelStyle,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(language, style: AppTextStyles.userValueStyle),
          ],
        ),
      ],
    );
  }
}
