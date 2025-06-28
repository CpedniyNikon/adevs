import 'package:adevs/core/utils/services/api_service.dart';
import 'package:adevs/core/utils/services/token_service.dart';

class AuthRepository {
  final ApiService apiService;
  final TokenService tokenService;

  AuthRepository({required this.apiService, required this.tokenService});

  Future<void> sendCode(String email) async {
    final response = await apiService.post(
      '/login',
      body: {'email': email},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send code: ${response.body}');
    }
  }

  Future<TokenPair> verifyCode(String email, String code) async {
    final response = await apiService.post(
      '/confirm_code',
      body: {'email': email, 'code': code},
    );

    if (response.statusCode == 200) {
      final tokens = TokenPair.fromJson(response.body);
      await tokenService.saveTokens(tokens);
      return tokens;
    } else {
      throw Exception('Invalid code: ${response.statusCode}');
    }
  }
}