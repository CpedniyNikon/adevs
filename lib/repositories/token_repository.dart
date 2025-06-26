class TokenRepository {
  final TokenService tokenService;
  final ApiService apiService;

  TokenRepository(this.tokenService, this.apiService);

  Future<String> getUserId(String jwt) async {
    final response = await apiService.get(
      '/auth',
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      return response.body['user_id'];
    } else {
      throw Exception('Failed to get user ID');
    }
  }

  Future<TokenPair> refreshToken(String refreshToken) async {
    final response = await apiService.post(
      '/refresh_token',
      body: {'token': refreshToken},
    );
    if (response.statusCode == 200) {
      return TokenPair.fromJson(response.body);
    } else {
      throw Exception('Token refresh failed');
    }
  }
}