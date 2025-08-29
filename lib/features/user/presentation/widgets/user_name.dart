import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';

class UserNameWidget extends StatelessWidget {
  final String userName;

  const UserNameWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: AppIconSizes.profile,
          color: profileDetailsColor,
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MessageLoader.get('username'),
              style: AppTextStyles.userLabelStyle,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(userName, style: AppTextStyles.userValueStyle),
          ],
        ),
      ],
    );
  }
}
