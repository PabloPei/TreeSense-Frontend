import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'package:treesense/features/auth/domain/usecases/login_user.dart';
import 'package:treesense/features/auth/domain/usecases/change_password.dart';
import 'package:treesense/features/auth/presentation/state/auth_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final loginUseCase = ref.read(loginUserProvider);
      final changePasswordUseCase = ref.read(changePasswordUseCaseProvider);
      return LoginController(loginUseCase, changePasswordUseCase);
    });

class LoginController extends StateNotifier<LoginState> {
  final LoginUser loginUser;
  final ChangePassword changePasswordUseCase;

  LoginController(this.loginUser, this.changePasswordUseCase)
    : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    if (!state.isFormValid) {
      state = state.copyWith(
        status:
            !state.isEmailValid
                ? LoginStatus.invalidEmail
                : LoginStatus.invalidPassword,
      );
      return;
    }

    state = state.copyWith(
      status: LoginStatus.authenticating,
      result: const AsyncValue.loading(),
    );

    try {
      final user = await loginUser(email, password);
      state = state.copyWith(
        status: LoginStatus.authenticated,
        result: AsyncValue.data(user),
      );
    } catch (e, st) {
      state = state.copyWith(
        status: LoginStatus.failure,
        result: AsyncValue.error(e, st),
      );
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = state.copyWith(status: LoginStatus.authenticating);

    try {
      await changePasswordUseCase(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      state = state.copyWith(status: LoginStatus.passwordChanged);
    } catch (e, st) {
      state = state.copyWith(
        status: LoginStatus.failure,
        result: AsyncValue.error(e, st),
      );
    }
  }

  void setEmailValid(bool isValid) {
    state = state.copyWith(isEmailValid: isValid, status: LoginStatus.initial);
  }

  void setEmailErrorMessage(String? message) {
    state = state.copyWith(
      emailErrorMessage: (message == null) ? " " : message,
    );
  }

  void setPasswordErrorMessage(String? message) {
    state = state.copyWith(passErrorMessage: (message == null) ? " " : message);
  }

  void setPasswordValid(bool isValid) {
    state = state.copyWith(
      isPasswordValid: isValid,
      status: LoginStatus.initial,
    );
  }
}
