import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:adevs/features/login/presentation/bloc/auth_state.dart';
import 'package:adevs/repositories/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<SendCodeEvent>(_onSendCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<LogoutEvent>(_onLogOut);
  }

  void _onSendCode(SendCodeEvent event, Emitter<AuthState> emit) async {
    if (!_validateEmail(event.email)) {
      emit(AuthError('Invalid email format'));
      return;
    }
    emit(AuthLoading());
    try {
      await authRepo.sendCode(event.email);
      emit(CodeSendingSuccess(event.email));
    } catch (e) {
      emit(CodeSendingFailure('Failed to send code'));
    }
  }

  void _onVerifyCode(VerifyCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final tokens = await authRepo.verifyCode(event.email, event.code);
      emit(CodeVerifyingSuccess(tokens, event.email));
    } catch (e) {
      emit(CodeVerifyingFailure('Invalid verification code', event.email));
    }
  }

  void _onLogOut(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
  }

  bool _validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email);
  }
}
