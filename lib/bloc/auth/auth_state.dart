import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class CodeSentSuccess extends AuthState {
  final String email;

  CodeSentSuccess(this.email);
}

class AuthSuccess extends AuthState {
  final TokenPair tokens;

  AuthSuccess(this.tokens);
}
