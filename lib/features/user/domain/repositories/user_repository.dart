import 'package:treesense/features/user/domain/entities/user.dart';
import 'dart:typed_data';

abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<void> uploadUserPhoto({
    required String email,
    required Uint8List photoBytes,
  });
}
