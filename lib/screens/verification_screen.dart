import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({required this.email});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.read<TokenBloc>().add(LoadUserEvent(
            state.tokens.jwt,
            state.tokens,
          ));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Code sent to ${widget.email}'),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Verification Code'),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is AuthError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        VerifyCodeEvent(
                          widget.email,
                          _codeController.text,
                        ),
                      );
                    },
                    child: const Text('Verify'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}