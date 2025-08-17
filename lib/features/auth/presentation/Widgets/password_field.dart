import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';

class LoginPassword extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? hint;

  const LoginPassword(this.controller, {this.hint, super.key});

  @override
  ConsumerState<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends ConsumerState<LoginPassword> {
  bool _obscureText = true;
  String? _errorText;

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  String? _validatePassword(String value) {
    if (value.trim().isEmpty) {
      return MessageLoader.get('error_empty_password');
    }
    return null;
  }

  void _handleValidation(String value) {
    final error = _validatePassword(value);
    final isValid = error == null;

    setState(() => _errorText = error);

    ref
        .read(loginControllerProvider.notifier)
        .setPasswordErrorMessage(_errorText);
    ref.read(loginControllerProvider.notifier).setPasswordValid(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: _handleValidation,
      decoration: InputDecoration(
        labelText: widget.hint ?? MessageLoader.get('password'),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: _toggleVisibility,
        ),
        filled: true,
        fillColor: Colors.blueGrey[50],
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
