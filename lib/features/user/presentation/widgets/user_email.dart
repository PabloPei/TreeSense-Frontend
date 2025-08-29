import 'package:flutter/material.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/app_theme.dart';

class UserEmailWidget extends StatelessWidget {
  final String email;

  const UserEmailWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.email_outlined,
          size: AppIconSizes.profile,
          color: profileDetailsColor,
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MessageLoader.get('email'),
              style: AppTextStyles.userLabelStyle,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(email, style: AppTextStyles.userValueStyle),
          ],
        ),
      ],
    );
  }
}
