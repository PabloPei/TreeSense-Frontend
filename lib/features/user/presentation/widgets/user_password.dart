import 'package:flutter/material.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/app_theme.dart';

class UserPasswordWidget extends StatefulWidget {
  final VoidCallback? onTap;

  const UserPasswordWidget({super.key, this.onTap});

  @override
  State<UserPasswordWidget> createState() => _UserPasswordWidgetState();
}

class _UserPasswordWidgetState extends State<UserPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            size: AppIconSizes.profile,
            color: profileDetailsColor,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MessageLoader.get('password'),
                  style: AppTextStyles.userLabelStyle,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  children: [
                    Text('••••••••', style: AppTextStyles.userValueStyle),
                    const SizedBox(width: 15),
                    Icon(Icons.edit, color: profileDetailsColor, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
