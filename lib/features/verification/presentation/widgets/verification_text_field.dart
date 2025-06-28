import 'package:flutter/material.dart';

class VerificationTextField extends StatefulWidget {
  final TextEditingController codeController;

  const VerificationTextField({super.key, required this.codeController});

  @override
  State<VerificationTextField> createState() => _VerificationTextFieldState();
}

class _VerificationTextFieldState extends State<VerificationTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.codeController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: 'Verification Code',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 3.0),
        ),
      ),
      keyboardType: TextInputType.number,
      maxLength: 6,
    );
  }
}
