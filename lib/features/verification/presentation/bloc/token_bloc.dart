import 'dart:async';

import 'package:adevs/core/utils/services/token_service.dart';
import 'package:adevs/features/verification/presentation/bloc/token_event.dart';
import 'package:adevs/features/verification/presentation/bloc/token_state.dart';
import 'package:adevs/repositories/token_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final TokenRepository tokenRepo;
  Timer? _tokenRefreshTimer;

  TokenBloc(this.tokenRepo) : super(TokenInitial()) {
    on<LoadUserEvent>(_onLoadUser);
    on<RefreshTokenEvent>(_onRefreshToken);
    on<TokenExpiredEvent>(_onTokenExpired);
    on<LogoutEvent>(_onLogout);
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

  void _onRefreshToken(
    RefreshTokenEvent event,
    Emitter<TokenState> emit,
  ) async {
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

  Future<void> _onLogout(LogoutEvent event, Emitter<TokenState> emit) async {
    try {
      _tokenRefreshTimer?.cancel();

      await tokenRepo.revokeToken();

      emit(TokenRevoked());
    } catch (e) {
      emit(TokenError('Logout failed: ${e.toString()}'));
    }
  }

  void _scheduleTokenRefresh(TokenPair tokens) {
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = Timer(
      const Duration(hours: 1),
      () => add(RefreshTokenEvent(tokens.refreshToken)),
    );
  }

  @override
  Future<void> close() {
    _tokenRefreshTimer?.cancel();
    return super.close();
  }
}
