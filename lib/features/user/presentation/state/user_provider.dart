import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/user/domain/repositories/user_datasource.dart';
import 'package:treesense/features/user/domain/repositories/user_repository.dart';
import 'package:treesense/features/user/domain/usecases/get_current_user.dart';
import 'package:treesense/features/user/domain/usecases/upload_user_photo.dart';
import 'package:treesense/features/user/infrastructure/datasources/user_datasource_impl.dart';
import 'package:treesense/features/user/infrastructure/repositories/user_repository_impl.dart';

final userDatasourceProvider = Provider<UserDatasource>((ref) {
  return UserDatasourceImpl();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final datasource = ref.read(userDatasourceProvider);
  return UserRepositoryImpl(datasource);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUser>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return GetCurrentUser(repository);
});

final uploadUserPhotoUseCaseProvider = Provider<UploadUserPhoto>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return UploadUserPhoto(repository);
});
