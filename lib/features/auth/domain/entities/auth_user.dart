abstract class AuthUser {
  String get email;
  String get accessToken;
  String get refreshToken;
  
  Map<String, dynamic> toJson();
}
