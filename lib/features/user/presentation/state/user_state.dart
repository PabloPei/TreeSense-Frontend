import 'package:treesense/features/user/domain/entities/user.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final String? error;

  UserState({this.user, this.isLoading = false, this.error});

  UserState copyWith({User? user, bool? isLoading, String? error}) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
