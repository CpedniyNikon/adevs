import 'package:adevs/core/utils/services/token_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class TokenState extends Equatable {}

class TokenInitial extends TokenState {
  @override
  List<Object?> get props => [];
}

class TokenLoading extends TokenState {
  @override
  List<Object?> get props => [];
}

class TokenError extends TokenState {
  final String message;

  TokenError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserAuthenticated extends TokenState {
  final String userId;
  final TokenPair tokens;

  UserAuthenticated(this.userId, this.tokens);

  @override
  List<Object?> get props => [userId, tokens];
}

class TokenExpired extends TokenState {
  @override
  List<Object?> get props => [];
}

class TokenRevoked extends TokenState {
  @override
  List<Object?> get props => [];
}
