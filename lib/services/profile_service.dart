import 'package:shoes_app/services/api_client.dart';

class ProfileService {
  Future<Map<String, dynamic>> getProfile(String token) {
    return ApiClient.get("/api/profile", token: token);
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String fullName,
    required String phone,
    String avatarUrl = "",
  }) {
    return ApiClient.put(
      "/api/profile",
      token: token,
      body: {
        "fullName": fullName,
        "phone": phone,
        "avatarUrl": avatarUrl,
      },
    );
  }
}
