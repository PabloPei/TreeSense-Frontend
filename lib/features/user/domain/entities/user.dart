import 'dart:typed_data';

abstract class User {
  String get userName;
  String get email;
  Uint8List? get photo;
  String get language;

  Map<String, dynamic> toJson();
}
