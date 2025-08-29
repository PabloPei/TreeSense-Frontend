import 'dart:typed_data';
import 'package:flutter/material.dart';

Future<void> showPhotoDialog({
  required BuildContext context,
  Uint8List? photo,
  String placeholderAsset = 'assets/icons/image_not_found_placeholder.jpg',
}) {
  final bool hasPhoto = photo != null && photo.isNotEmpty;

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'PhotoDialog',
    barrierColor: Colors.black.withValues(alpha: 0.8),
    transitionDuration: const Duration(milliseconds: 100),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Opacity(
              opacity: animation.value,
              child: Transform.scale(
                scale: animation.value,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 300,
                  ),
                  child:
                      hasPhoto
                          ? Image.memory(photo, fit: BoxFit.contain)
                          : Image.asset(placeholderAsset, fit: BoxFit.contain),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
