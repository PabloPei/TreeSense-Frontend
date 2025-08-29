import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/user/presentation/state/user_controller.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class UserLogout {
  static void showLogoutDialog({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(MessageLoader.get('logout_confirmation_title')),
          content: Text(MessageLoader.get('logout_confirmation_message')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                MessageLoader.get('cancel'),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _performLogout(context: context, ref: ref);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: logOutColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: Text(MessageLoader.get('logout')),
            ),
          ],
        );
      },
    );
  }

  static void _performLogout({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      // Mostrar loading indicator
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      await ref.read(userControllerProvider.notifier).logout();

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        _showLogoutError(context);
      }
    }
  }

  static void _showLogoutError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline),
            const SizedBox(width: 8),
            Expanded(child: Text(MessageLoader.get('logout_error'))),
          ],
        ),
        backgroundColor: logOutColor,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: MessageLoader.get('dismiss'),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Método directo para logout sin confirmación (útil para otros casos)
  static Future<void> performDirectLogout({
    required BuildContext context,
    required WidgetRef ref,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading && context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      await ref.read(userControllerProvider.notifier).logout();

      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (showLoading && context.mounted) {
        Navigator.of(context).pop();
      }

      if (context.mounted) {
        _showLogoutError(context);
      }
    }
  }
}

// Widget para botón de logout reutilizable
class LogoutButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final Color? color;
  final bool showIcon;
  final bool isOutlined;

  const LogoutButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.color,
    this.showIcon = true,
    this.isOutlined = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonText = text ?? MessageLoader.get('logout');
    final buttonIcon = icon ?? Icons.logout;
    final buttonColor = color ?? logOutColor;

    final onTap =
        onPressed ??
        () {
          UserLogout.showLogoutDialog(context: context, ref: ref);
        };

    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: onTap,
        icon:
            showIcon
                ? Icon(buttonIcon, color: buttonColor)
                : const SizedBox.shrink(),
        label: Text(buttonText, style: TextStyle(color: buttonColor)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: buttonColor),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: onTap,
      icon: showIcon ? Icon(buttonIcon) : const SizedBox.shrink(),
      label: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

// Widget para icono de logout en AppBar o header
class LogoutIconButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final String? tooltip;

  const LogoutIconButton({
    super.key,
    this.onPressed,
    this.color,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onTap =
        onPressed ??
        () {
          UserLogout.showLogoutDialog(context: context, ref: ref);
        };

    return IconButton(
      icon: Icon(Icons.logout, color: color ?? logOutColor, size: size),
      onPressed: onTap,
      tooltip: tooltip ?? MessageLoader.get('logout'),
    );
  }
}
