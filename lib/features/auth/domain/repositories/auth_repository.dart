import 'package:treesense/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String email, String password);
  Future<void> refreshToken();
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
