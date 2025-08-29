import 'dart:typed_data';
import 'package:treesense/features/user/domain/repositories/user_repository.dart';

class UploadUserPhoto {
  final UserRepository repository;

  UploadUserPhoto(this.repository);

  Future<void> call({
    required String email,
    required Uint8List photoBytes,
  }) async {
    await repository.uploadUserPhoto(email: email, photoBytes: photoBytes);
  }
}
