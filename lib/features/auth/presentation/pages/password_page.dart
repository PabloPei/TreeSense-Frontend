import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/auth/presentation/Widgets/password_form.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';
import 'package:treesense/features/auth/presentation/state/auth_state.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() =>
      _ChangePasswordFieldState();
}

class _ChangePasswordFieldState extends ConsumerState<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleChangePassword() async {
    final loginController = ref.read(loginControllerProvider.notifier);

    await loginController.changePassword(
      _currentPasswordController.text,
      _newPasswordController.text,
    );

    final state = ref.read(loginControllerProvider);

    if (state.status == LoginStatus.failure) {
      BlockErrorDialog.showErrorDialog(
        context,
        MessageLoader.get('change_password_error'),
        state.result.error?.toString() ?? MessageLoader.get('error_unknow'),
      );
    } else if (state.status == LoginStatus.passwordChanged) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } else {
      BlockErrorDialog.showErrorDialog(
        context,
        MessageLoader.get('login_error'),
        '${state.emailErrorMessage}\n${state.passErrorMessage}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangePasswordForm(
          currentPasswordController: _currentPasswordController,
          newPasswordController: _newPasswordController,
          confirmPasswordController: _confirmPasswordController,
          onChangePassword: _handleChangePassword,
          isLoading: _isLoading,
        ),
      ),
    );
  }
}
