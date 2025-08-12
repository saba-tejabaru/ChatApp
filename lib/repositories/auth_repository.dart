import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';
import '../models/user.dart';

class AuthRepository {
  static const _tokenKey = 'auth_token';
  UserModel? _user;

  Future<UserModel> login({
    required String email,
    required String password,
    required String role,
  }) async {
    final client = ApiClient().dio;
    final resp = await client.post('/user/login', data: {
      'email': email,
      'password': password,
      'role': role,
    });

    // Inspect resp.data to pick token & user.
    final data = resp.data;
    // Typical variations: data could be { token:..., user: {...} } or user fields at root
    String token = '';
    Map<String, dynamic> userJson = {};

    if (data is Map<String, dynamic>) {
      token = data['token'] ?? data['accessToken'] ?? '';
      if (data['user'] != null && data['user'] is Map<String, dynamic>) {
        userJson = Map<String, dynamic>.from(data['user'] as Map);
      } else {
        userJson = Map<String, dynamic>.from(data);
      }
    } else {
      throw Exception('Unexpected login response structure');
    }

    final user = UserModel.fromJson(userJson, token: token);
    _user = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _user = null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<UserModel?> currentUser() async {
    if (_user != null) return _user;
    // optionally we could restore from local storage if we store user JSON
    return null;
  }
}
