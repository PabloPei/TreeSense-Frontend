import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/user/domain/usecases/get_current_user.dart';
import 'package:treesense/features/user/domain/usecases/upload_user_photo.dart';
import 'package:treesense/features/user/presentation/state/user_provider.dart';
import 'package:treesense/features/user/presentation/state/user_state.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/shared/utils/app_utils.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, UserState>((ref) {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      final uploadUserPhoto = ref.read(uploadUserPhotoUseCaseProvider);
      return UserController(getCurrentUser, uploadUserPhoto);
    });

class UserController extends StateNotifier<UserState> {
  final GetCurrentUser getCurrentUser;
  final UploadUserPhoto uploadUserPhotoUseCase;

  UserController(this.getCurrentUser, this.uploadUserPhotoUseCase)
    : super(UserState()) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await getCurrentUser();
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> logout() async {
    final AuthStorage authStorage = AuthStorage();
    await authStorage.clearTokens();
    state = state.copyWith(user: null, isLoading: false, error: null);
  }

  Future<void> uploadUserPhoto(Uint8List photo) async {
    try {
      state = state.copyWith(isLoading: true);

      final user = state.user;
      if (user == null) {
        throw Exception(MessageLoader.get("error_user_photo_upload"));
      }

      await uploadUserPhotoUseCase(email: user.email, photoBytes: photo);

      final updatedUser = await getCurrentUser();
      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
