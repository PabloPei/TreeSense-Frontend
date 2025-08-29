import 'package:treesense/features/user/domain/entities/user.dart';
import 'package:treesense/features/user/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  Future<User> call() async {
    return await repository.getCurrentUser();
  }
}
