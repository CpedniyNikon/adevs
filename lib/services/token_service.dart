import 'package:shared_preferences/shared_preferences.dart';

class TokenPair {
  final String jwt;
  final String refreshToken;

  TokenPair({required this.jwt, required this.refreshToken});

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      jwt: json['jwt'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refresh_token': refreshToken,
  };
}

class TokenService {
  static const _jwtKey = 'auth_jwt';
  static const _refreshTokenKey = 'auth_refresh_token';

  Future<void> saveTokens(TokenPair tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtKey, tokens.jwt);
    await prefs.setString(_refreshTokenKey, tokens.refreshToken);
  }

  Future<TokenPair?> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString(_jwtKey);
    final refreshToken = prefs.getString(_refreshTokenKey);

    if (jwt != null && refreshToken != null) {
      return TokenPair(jwt: jwt, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtKey);
    await prefs.remove(_refreshTokenKey);
  }

  Future<void> saveJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtKey, jwt);
  }
}