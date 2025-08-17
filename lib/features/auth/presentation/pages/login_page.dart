import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/auth/presentation/Widgets/login_form.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';
import 'package:treesense/features/auth/presentation/state/auth_state.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/features/auth/presentation/Widgets/developers_message.dart';
import 'package:treesense/core/theme/format.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  Future<void> _handleLogin(BuildContext context) async {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    final loginController = ref.read(loginControllerProvider.notifier);
    await loginController.login(email, password);

    final state = ref.read(loginControllerProvider);

    if (state.status == LoginStatus.failure) {
      BlockErrorDialog.showErrorDialog(
        context,
        MessageLoader.get('login_error'),
        state.result.error?.toString() ?? MessageLoader.get('error_unknow'),
      );
    } else if (state.status == LoginStatus.authenticated) {
      if (context.mounted) {
        context.go('/home');
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
    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              LoginForm(
                emailController: _emailCtrl,
                passwordController: _passwordCtrl,
                onLogin: () => _handleLogin(context),
                isLoading: state.status == LoginStatus.authenticating,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              const SizedBox(height: AppSpacing.xl),
              const DevelopersMessage(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
