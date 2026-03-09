import 'package:shoes_app/services/api_client.dart';

class AuthService {
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) {
    return ApiClient.post(
      "/api/auth/register",
      body: {
        "fullName": fullName,
        "email": email,
        "password": password,
        "phone": phone ?? "",
      },
    );
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) {
    return ApiClient.post(
      "/api/auth/login",
      body: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<Map<String, dynamic>> me(String token) {
    return ApiClient.get("/api/auth/me", token: token);
  }

  Future<Map<String, dynamic>> logout(String token) {
    return ApiClient.post("/api/auth/logout", token: token);
  }
}
