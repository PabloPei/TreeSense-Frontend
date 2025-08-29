import 'package:treesense/features/user/domain/entities/user.dart';
import 'dart:typed_data';

abstract class UserDatasource {
  Future<User> getCurrentUser();
  Future<void> uploadUserPhoto(String email, Uint8List photoBytes);
}
