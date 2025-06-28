import 'package:adevs/core/utils/services/token_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}

class CodeSendingSuccess extends AuthState {
  final String email;

  const CodeSendingSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class CodeSendingFailure extends AuthState {
  final String error;

  const CodeSendingFailure(this.error);

  @override
  List<Object> get props => [error];
}

class CodeVerifyingSuccess extends AuthState {
  final TokenPair tokens;
  final String email;

  const CodeVerifyingSuccess(this.tokens, this.email);

  @override
  List<Object> get props => [tokens, email];
}

class CodeVerifyingFailure extends AuthState {
  final String error;
  final String email;

  const CodeVerifyingFailure(this.error, this.email);

  @override
  List<Object> get props => [error, email];
}
