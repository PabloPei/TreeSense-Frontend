import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/features/user/presentation/widgets/user_name.dart';
import 'package:treesense/features/user/presentation/widgets/user_email.dart';
import 'package:treesense/features/user/presentation/widgets/user_language.dart';
import 'package:treesense/features/user/presentation/widgets/user_password.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class UserInfoSection extends ConsumerWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userControllerProvider);
    final user = state.user;

    if (user == null) {
      return Center(child: Text(MessageLoader.get('error_unknow')));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserNameWidget(userName: user.userName),
        const SizedBox(height: AppSpacing.xl),
        UserEmailWidget(email: user.email),
        const SizedBox(height: AppSpacing.xl),
        UserPasswordWidget(onTap: () => context.push('/password')),
        const SizedBox(height: AppSpacing.xl),
        UserLanguageWidget(language: user.language),
      ],
    );
  }
}
