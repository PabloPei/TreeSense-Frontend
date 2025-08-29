//import 'dart:ffi';

import 'package:treesense/features/user/domain/entities/user.dart';
import 'package:treesense/features/user/domain/repositories/user_datasource.dart';
import 'package:treesense/features/user/domain/repositories/user_repository.dart';
import 'dart:typed_data';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<User> getCurrentUser() async {
    return await datasource.getCurrentUser();
  }

  @override
  Future<void> uploadUserPhoto({
    required String email,
    required Uint8List photoBytes,
  }) {
    return datasource.uploadUserPhoto(email, photoBytes);
  }
}
