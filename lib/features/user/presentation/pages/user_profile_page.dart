import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_logout.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/features/user/presentation/widgets/user_info_section.dart';
import 'package:treesense/features/user/presentation/widgets/user_photo_editor.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userControllerProvider);
    final user = state.user;

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return WarningMessage(
                title: MessageLoader.get('error_title'),
                message: state.error!,
              );
            }

            if (user == null) {
              return Center(child: Text(MessageLoader.get('error_unknow')));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () => context.pop(),
                            tooltip: MessageLoader.get('back_tooltip'),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      UserPhotoEditor(photo: user.photo),

                      const SizedBox(height: AppSpacing.xxxl),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 3,
                        color: profileDetailsColor,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      UserInfoSection(),

                      const SizedBox(height: AppSpacing.xxl),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: const LogoutButton(),
                      ),

                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
