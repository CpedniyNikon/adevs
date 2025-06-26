import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepo;
  Timer? _tokenRefreshTimer;

  TokenBloc(this.tokenRepo) : super(TokenInitial()) {
    on<LoadUserEvent>(_onLoadUser);
    on<RefreshTokenEvent>(_onRefreshToken);
    on<TokenExpiredEvent>(_onTokenExpired);
  }

  void _onLoadUser(LoadUserEvent event, Emitter<TokenState> emit) async {
    try {
      final userId = await tokenRepo.getUserId(event.jwt);
      emit(UserAuthenticated(userId, event.tokens));
      _scheduleTokenRefresh(event.tokens);
    } catch (e) {
      emit(TokenError('Authentication failed'));
    }
  }

  void _onRefreshToken(RefreshTokenEvent event, Emitter<TokenState> emit) async {
    try {
      final newTokens = await tokenRepo.refreshToken(event.refreshToken);
      final userId = await tokenRepo.getUserId(newTokens.jwt);
      emit(UserAuthenticated(userId, newTokens));
      _scheduleTokenRefresh(newTokens);
    } catch (e) {
      emit(TokenError('Session expired'));
    }
  }

  void _onTokenExpired(TokenExpiredEvent event, Emitter<TokenState> emit) {
    emit(TokenExpired());
  }

  void _scheduleTokenRefresh(TokenPair tokens) {
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = Timer(
      const Duration(minutes: 55), // Обновляем за 5 мин до истечения
          () => add(RefreshTokenEvent(tokens.refreshToken)),
    );
  }

  @override
  Future<void> close() {
    _tokenRefreshTimer?.cancel();
    return super.close();
  }
}