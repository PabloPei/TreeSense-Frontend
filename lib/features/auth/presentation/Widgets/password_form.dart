import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/auth/presentation/Widgets/password_field.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class ChangePasswordForm extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onChangePassword;
  final bool isLoading;

  const ChangePasswordForm({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onChangePassword,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            children: [
              // Header con botón de back
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => context.pop(),
                    tooltip: MessageLoader.get('back_tooltip'),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              Text(
                MessageLoader.get('change_password'),
                style: AppTextStyles.titleStyle,
              ),

              const SizedBox(height: AppSpacing.xl),

              LoginPassword(
                currentPasswordController,
                hint: MessageLoader.get("field_current_password"),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Campo de nueva contraseña
              LoginPassword(
                newPasswordController,
                hint: MessageLoader.get("field_new_password"),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Campo de confirmar contraseña
              LoginPassword(
                confirmPasswordController,
                hint: MessageLoader.get("field_repeat_password"),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Botón de cambiar contraseña
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: isLoading ? null : onChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: profileDetailsColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    ),
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Text(
                            MessageLoader.get('change_password'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
