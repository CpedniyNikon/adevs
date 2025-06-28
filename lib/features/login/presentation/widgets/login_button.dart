import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  const LoginButton({super.key, required this.emailController});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthBloc>().add(
          SendCodeEvent(widget.emailController.text),
        );
      },
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          color: Color(0xffF2796B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Login',
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
