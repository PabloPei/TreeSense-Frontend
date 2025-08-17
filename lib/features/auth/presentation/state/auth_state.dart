import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/auth/domain/entities/auth_user.dart';

enum LoginStatus {
  initial,
  invalidEmail,
  invalidPassword,
  authenticating,
  authenticated,
  failure,
  passwordChanged,
}

class LoginState {
  final LoginStatus status;
  final AsyncValue<AuthUser?> result;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String emailErrorMessage;
  final String passErrorMessage;

  LoginState({
    required this.status,
    required this.result,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.emailErrorMessage,
    required this.passErrorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      status: LoginStatus.initial,
      result: const AsyncValue.data(null),
      isEmailValid: false,
      isPasswordValid: false,
      emailErrorMessage: MessageLoader.get("error_empty_email"),
      passErrorMessage: MessageLoader.get("error_empty_password"),
    );
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState copyWith({
    LoginStatus? status,
    AsyncValue<AuthUser?>? result,
    bool? isEmailValid,
    bool? isPasswordValid,
    String? emailErrorMessage,
    String? passErrorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      result: result ?? this.result,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passErrorMessage: passErrorMessage ?? this.passErrorMessage,
    );
  }
}
