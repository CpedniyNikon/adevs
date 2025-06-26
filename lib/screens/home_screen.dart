import 'package:adevs/bloc/token/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TokenBloc, TokenState>(
      listener: (context, state) {
        if (state is TokenExpired || state is TokenError) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Scaffold(
            appBar: AppBar(title: const Text('Home')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Authenticated', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  Text('User ID: ${state.userId}'),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TokenBloc>().add(LogoutEvent());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}