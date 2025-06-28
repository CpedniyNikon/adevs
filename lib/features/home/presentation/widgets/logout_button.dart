import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_event.dart'
    as token;
import 'package:adevs/features/login/presentation/bloc/auth_event.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TokenBloc>().add(token.LogoutEvent());
        context.read<AuthBloc>().add(auth.LogoutEvent());
        context.go('/login');
      },
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          color: Color(0xffF2796B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Log out',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
