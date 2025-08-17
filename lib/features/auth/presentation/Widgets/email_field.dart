import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';
import 'package:treesense/core/theme/format.dart';

class EmailField extends ConsumerStatefulWidget {
  final TextEditingController controller;

  const EmailField(this.controller, {super.key});

  @override
  ConsumerState<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends ConsumerState<EmailField> {
  String? _errorText;

  void _validateEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _errorText = MessageLoader.get("error_empty_email");
      } else {
        _errorText = null;
      }
    });

    final isValid = email.isNotEmpty;

    ref.read(loginControllerProvider.notifier).setEmailErrorMessage(_errorText);
    ref.read(loginControllerProvider.notifier).setEmailValid(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: _validateEmail,
      decoration: InputDecoration(
        labelText: MessageLoader.get('email'),
        filled: true,
        contentPadding: const EdgeInsets.only(left: 30),
        errorText: _errorText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
      ),
    );
  }
}
