import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class SendCodeEvent extends AuthEvent {
  final String email;

  SendCodeEvent(this.email);
}

class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;

  VerifyCodeEvent(this.email, this.code);
}
