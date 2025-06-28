import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyButton extends StatefulWidget {
  final TextEditingController codeController;
  final String email;

  const VerifyButton({
    super.key,
    required this.codeController,
    required this.email,
  });

  @override
  State<VerifyButton> createState() => _VerifyButtonState();
}

class _VerifyButtonState extends State<VerifyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthBloc>().add(
          VerifyCodeEvent(widget.email, widget.codeController.text),
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
            'Verify',
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
