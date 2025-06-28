import 'package:adevs/core/utils/services/token_service.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenError extends TokenState {
  final String message;

  TokenError(this.message);
}

class UserAuthenticated extends TokenState {
  final String userId;
  final TokenPair tokens;

  UserAuthenticated(this.userId, this.tokens);
}

class TokenExpired extends TokenState {}

class TokenRevoked extends TokenState {}