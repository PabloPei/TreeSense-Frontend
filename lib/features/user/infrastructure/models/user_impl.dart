import 'dart:convert';
import 'dart:typed_data';
import 'package:treesense/features/user/domain/entities/user.dart';

class UserImpl implements User {
  @override
  final String email;

  @override
  final String userName;

  @override
  final String language;

  @override
  final Uint8List? photo;

  const UserImpl({
    required this.email,
    required this.userName,
    required this.language,
    required this.photo,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'language': language,
      'photo': photo,
    };
  }

  factory UserImpl.fromJson(Map<String, dynamic> json) {
    final email = json['email'] ?? '';
    final userName = json['userName'] ?? '';
    final language = json['languageCode'] ?? 'es';

    Uint8List? photoBytes;
    if (json['photo'] != null && json['photo'] is String) {
      try {
        photoBytes = base64Decode(json['photo']);
      } catch (_) {
        photoBytes = null;
      }
    }

    return UserImpl(
      userName: userName,
      email: email,
      language: language,
      photo: photoBytes,
    );
  }
}
