import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoes_app/utils/api_config.dart';

class ApiClient {
  static Future<Map<String, dynamic>> get(
    String path, {
    String? token,
    Map<String, String>? query,
  }) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}$path").replace(
      queryParameters: query,
    );

    final response = await http.get(uri, headers: _headers(token: token));
    return _parse(response);
  }

  static Future<Map<String, dynamic>> post(
    String path, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}$path");
    final response = await http.post(
      uri,
      headers: _headers(token: token),
      body: jsonEncode(body ?? {}),
    );
    return _parse(response);
  }

  static Future<Map<String, dynamic>> put(
    String path, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}$path");
    final response = await http.put(
      uri,
      headers: _headers(token: token),
      body: jsonEncode(body ?? {}),
    );
    return _parse(response);
  }

  static Map<String, String> _headers({String? token}) {
    final headers = {
      "Content-Type": "application/json",
    };

    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  static Map<String, dynamic> _parse(http.Response response) {
    final Map<String, dynamic> data = response.body.isEmpty
        ? {}
        : (jsonDecode(response.body) as Map<String, dynamic>);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    final message = data["message"]?.toString() ?? "Request failed";
    throw Exception(message);
  }
}
