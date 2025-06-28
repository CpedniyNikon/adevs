import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_event.dart'
    as token;
import 'package:adevs/features/login/presentation/bloc/auth_event.dart' as auth;
import 'package:adevs/features/verification/presentation/bloc/token_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TokenBloc, TokenState>(
      listener: (context, state) {
        if (state is TokenExpired || state is TokenError) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Color(0xffF6F6F6),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Authenticated',
                        style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        'User ID: ${state.userId}',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 40),
                      InkWell(
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
                      ),
                    ],
                  ),
                ),
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
