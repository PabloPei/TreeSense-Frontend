import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:go_router/go_router.dart';
//import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
//import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/table/presentation/widgets/export_button.dart';
import 'package:treesense/features/table/presentation/widgets/trees_table.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider);
    final userPhoto = userState.user?.photo;

    final userPhotoDiameter = context.screenWidth * 0.08;
    final formButtonWidth = context.screenWidth * 0.08;
    final fontSize = formButtonWidth * 0.01;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: userPhotoDiameter,
                      height: userPhotoDiameter,
                      child: GestureDetector(
                        onTap: () => context.push('/profile'),
                        child: Tooltip(
                          message: MessageLoader.get('see_profile'),
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: UserProfilePhoto(
                              photo: userPhoto,
                              radius: userPhotoDiameter / 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: ExportButton(
                          width: formButtonWidth,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: TreesTable.sample(count: 200, initialRowsPerPage: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
