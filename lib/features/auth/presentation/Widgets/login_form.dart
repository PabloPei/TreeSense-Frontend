import 'package:flutter/material.dart';
import 'package:treesense/features/auth/presentation/Widgets/login_button.dart';
import 'package:treesense/features/auth/presentation/Widgets/email_field.dart';
import 'package:treesense/features/auth/presentation/Widgets/password_field.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final ldzWidth = context.screenWidth * 0.25;
    final faubaWidth = context.screenWidth * 0.5;
    //final logoSpacingWidth = context.screenWidth * 0.02;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.xl),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logos/logo_LDZ.png',
                    width: ldzWidth,
                    fit: BoxFit.contain,
                  ),
                  //SizedBox(width: logoSpacingWidth),
                  Image.asset(
                    'assets/logos/logo_fauba.png',
                    width: faubaWidth,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                MessageLoader.get('login_title'),
                style: AppTextStyles.titleStyle,
                textAlign: TextAlign.center,
              ),

              Text(
                MessageLoader.get('login_description'),
                style: AppTextStyles.captionTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),

              const SizedBox(height: AppSpacing.xl),

              EmailField(emailController),
              const SizedBox(height: AppSpacing.sm),
              LoginPassword(passwordController),
              const SizedBox(height: AppSpacing.md),
              LoginButton(onPressed: onLogin, isLoading: isLoading),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}
