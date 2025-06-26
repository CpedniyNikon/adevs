import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw HttpException(
        'Request failed: ${response.statusCode}',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw HttpException(
        'Request failed: ${response.statusCode}',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  HttpException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'HttpException: $message (Status $statusCode)';
}