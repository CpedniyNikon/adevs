class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<void> sendCode(String email) async {
    final response = await apiService.post(
      '/login',
      body: {'email': email},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send code');
    }
  }

  Future<TokenPair> verifyCode(String email, String code) async {
    final response = await apiService.post(
      '/confirm_code',
      body: {'email': email, 'code': code},
    );
    if (response.statusCode == 200) {
      return TokenPair.fromJson(response.body);
    } else {
      throw Exception('Invalid code');
    }
  }
}