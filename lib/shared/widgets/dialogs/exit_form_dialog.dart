import 'package:flutter/material.dart';
import 'package:treesense/shared/utils/app_utils.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(MessageLoader.get('exit_title')),
          content: Text(MessageLoader.get('exit_warning_message')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(MessageLoader.get('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(MessageLoader.get('exit')),
            ),
          ],
        ),
  );

  return result ?? false;
}
