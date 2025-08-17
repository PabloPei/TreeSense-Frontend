import 'package:treesense/features/auth/domain/repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository repository;

  RefreshToken({required this.repository});

  Future<void> call() async {
    return await repository.refreshToken();
  }
}
