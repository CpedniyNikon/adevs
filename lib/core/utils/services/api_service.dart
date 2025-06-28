import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<ApiResponse> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: body != null ? jsonEncode(body) : null,
    );
    return ApiResponse(
      statusCode: response.statusCode,
      body: _decodeResponse(response),
    );
  }

  Future<ApiResponse> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    return ApiResponse(
      statusCode: response.statusCode,
      body: _decodeResponse(response),
    );
  }

  dynamic _decodeResponse(http.Response response) {
    if (response.body.isEmpty) return null;
    return jsonDecode(response.body);
  }
}

class ApiResponse {
  final int statusCode;
  final dynamic body;

  ApiResponse({required this.statusCode, this.body});
}