import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:adevs/features/login/presentation/bloc/auth_state.dart';
import 'package:adevs/features/verification/presentation/bloc/token_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CodeVerifyingSuccess) {
          context.read<TokenBloc>().add(
            LoadUserEvent(state.tokens.jwt, state.tokens),
          );
          context.go('/home');
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Color(0xffF6F6F6),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Verify'),
                        SizedBox(width: 4),
                        Image.asset('assets/user.png'),
                      ],
                    ),
                    SizedBox(height: 49),
                    Image.asset('assets/shopping.png'),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 26,
                      child: Center(
                        child: Text(
                          'Enter your verification code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffF2796B),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 31),
                    if (state is CodeSendingSuccess)
                      Text('Code sent to ${state.email}'),
                    TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Verification Code',
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
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    SizedBox(height: 11),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            'Send one more time?',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Builder(
                      builder: (context) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is AuthError) {
                          return Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else if (state is CodeSendingSuccess) {
                          return InkWell(
                            onTap: () {
                              context.read<AuthBloc>().add(
                                VerifyCodeEvent(
                                  state.email,
                                  _codeController.text,
                                ),
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
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
