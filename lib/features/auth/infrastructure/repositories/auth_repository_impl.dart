import 'package:treesense/features/auth/domain/repositories/auth_datasource.dart';
import 'package:treesense/features/auth/infrastructure/models/auth_user_impl.dart';
import 'package:treesense/features/auth/domain/entities/auth_user.dart';
import 'package:treesense/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<AuthUser> login(String email, String password) async {
    final json = await datasource.login(email, password);
    return AuthUserImpl.fromJson(json);
  }

  @override
  Future<void> refreshToken() async {
    await datasource.refreshToken();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await datasource.changePassword(currentPassword, newPassword);
  }
}
