import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/domain/repositories/auth_datasource.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class AuthException implements Exception {
  final int statusCode;
  final String message;

  AuthException(this.statusCode, this.message);

  @override
  String toString() => 'AuthException($statusCode): $message';
}

class AuthDatasourceImpl implements AuthDatasource {
  final AuthStorage _authStorage = AuthStorage();

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final statusCode = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (statusCode == 200) {
      final accessToken = responseBody['accessToken'] as String?;
      final refreshToken = responseBody['refreshToken'] as String?;

      if (accessToken != null && refreshToken != null) {
        await _authStorage.saveTokens(accessToken, refreshToken);
        return responseBody;
      } else {
        throw AuthException(
          statusCode,
          MessageLoader.get('error_access_token'),
        );
      }
    } else {
      final errorMessage =
          responseBody['error'] ?? MessageLoader.get('error_unkown');
      throw AuthException(statusCode, errorMessage);
    }
  }

  @override
  Future<bool> refreshToken() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/refresh-token');

    final refreshToken = await _authStorage.getRefreshToken();

    if (refreshToken == null) {
      throw Exception(MessageLoader.get('error_refresh_token'));
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );

    final statusCode = response.statusCode;
    final responseBody = jsonDecode(response.body);

    if (statusCode == 200) {
      final accessToken = responseBody['accessToken'] as String?;

      if (accessToken != null) {
        await _authStorage.saveTokens(accessToken, refreshToken);
        return responseBody;
      } else {
        throw AuthException(
          statusCode,
          MessageLoader.get('error_access_token'),
        );
      }
    } else {
      final errorMessage =
          responseBody['error'] ?? MessageLoader.get('error_unkown');
      throw AuthException(statusCode, errorMessage);
    }
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/user/password');
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final body = jsonEncode({
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }
}
