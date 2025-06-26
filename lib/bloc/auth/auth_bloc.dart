import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<SendCodeEvent>(_onSendCode);
    on<VerifyCodeEvent>(_onVerifyCode);
  }

  void _onSendCode(SendCodeEvent event, Emitter<AuthState> emit) async {
    if (!_validateEmail(event.email)) {
      emit(AuthError('Invalid email format'));
      return;
    }

    emit(AuthLoading());
    try {
      await authRepo.sendCode(event.email);
      emit(CodeSentSuccess(event.email));
    } catch (e) {
      emit(AuthError('Failed to send code'));
    }
  }

  void _onVerifyCode(VerifyCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final tokens = await authRepo.verifyCode(event.email, event.code);
      emit(AuthSuccess(tokens));
    } catch (e) {
      emit(AuthError('Invalid verification code'));
    }
  }

  bool _validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email);
  }
}