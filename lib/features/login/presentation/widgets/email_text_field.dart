import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmailTextField extends StatefulWidget {
  final TextEditingController emailController;
  const EmailTextField({super.key, required this.emailController});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) => TextField(
        controller: widget.emailController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Email',
          labelStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            color: Color(0xff545151),
          ),
          errorText: state is AuthError ? state.error : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 3.0,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
