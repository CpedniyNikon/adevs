import 'package:adevs/core/utils/services/api_service.dart';
import 'package:adevs/core/utils/services/token_service.dart';

class TokenRepository {
  final TokenService tokenService;
  final ApiService apiService;

  TokenRepository({required this.tokenService, required this.apiService});

  Future<String> getUserId(String jwt) async {
    final response = await apiService.get(
      '/auth',
      headers: {'Auth': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      return response.body['user_id'] as String;
    } else {
      throw Exception('Failed to get user ID: ${response.statusCode}');
    }
  }

  Future<TokenPair> refreshToken(String refreshToken) async {
    final response = await apiService.post(
      '/refresh_token',
      body: {'token': refreshToken},
    );

    if (response.statusCode == 200) {
      final tokens = TokenPair.fromJson(response.body);
      await tokenService.saveTokens(tokens);
      return tokens;
    } else {
      throw Exception('Token refresh failed: ${response.statusCode}');
    }
  }

  Future<void> revokeToken() async {
    await tokenService.deleteTokens();
  }
}
