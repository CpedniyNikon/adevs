import 'package:flutter/material.dart';

@immutable
abstract class TokenEvent {}

class LoadUserEvent extends TokenEvent {
  final String jwt;
  final TokenPair tokens;

  LoadUserEvent(this.jwt, this.tokens);
}

class RefreshTokenEvent extends TokenEvent {
  final String refreshToken;

  RefreshTokenEvent(this.refreshToken);
}

class TokenExpiredEvent extends TokenEvent {}

class LogoutEvent extends TokenEvent {}