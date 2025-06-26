import 'package:adevs/bloc/auth/auth_bloc.dart';
import 'package:adevs/bloc/auth/auth_state.dart'
import 'package:adevs/screens/verification_screen.dart';;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CodeSentSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(email: state.email),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: state is AuthError ? state.message : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(SendCodeEvent(_emailController.text.trim()));
                    },
                    child: const Text('Send Code'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}