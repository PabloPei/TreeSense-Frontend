import 'package:flutter/material.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';

class DevelopersMessage extends StatelessWidget {
  const DevelopersMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Text(
          MessageLoader.get('developers_message'),
          textAlign: TextAlign.center,
          style: AppTextStyles.developersMessageStyle,
        ),
      ),
    );
  }
}
