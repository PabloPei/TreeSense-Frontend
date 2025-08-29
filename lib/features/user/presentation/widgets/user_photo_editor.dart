import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/shared/widgets/dialogs/show_photo_dialog.dart';

class UserPhotoEditor extends ConsumerWidget {
  final Uint8List? photo;

  const UserPhotoEditor({super.key, required this.photo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap:
              () => showPhotoDialog(
                context: context,
                photo: photo,
                placeholderAsset: 'assets/icons/user.png',
              ),
          child: Container(
            width: 160,
            height: 160,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: profileDetailsColor, width: 1),
            ),
            child: UserProfilePhoto(photo: photo, radius: 80),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final XFile? pickedFile = await picker.pickImage(
                source: ImageSource.gallery,
              );

              if (pickedFile != null) {
                try {
                  final bytes = await pickedFile.readAsBytes();

                  await ref
                      .read(userControllerProvider.notifier)
                      .uploadUserPhoto(bytes);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          MessageLoader.get("user_profile_photo_uploaded"),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              } else {
                BlockErrorDialog.showErrorDialog(
                  context,
                  MessageLoader.get("error_title"),
                  MessageLoader.get("error_not_photo_selected"),
                );
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: profileDetailsColor,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
