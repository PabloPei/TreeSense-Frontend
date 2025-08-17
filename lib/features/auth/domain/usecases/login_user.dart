import 'package:treesense/features/auth/domain/repositories/auth_repository.dart';
import 'package:treesense/features/auth/domain/entities/auth_user.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser({required this.repository});

  Future<AuthUser> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
