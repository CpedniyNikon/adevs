import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:adevs/features/login/presentation/bloc/auth_state.dart';
import 'package:adevs/features/verification/presentation/bloc/token_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_event.dart';
import 'package:adevs/features/verification/presentation/widgets/verification_text_field.dart';
import 'package:adevs/features/verification/presentation/widgets/verify_button.dart';
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
                    VerificationTextField(codeController: _codeController),
                    SizedBox(height: 11),
                    if (state is CodeSendingSuccess ||
                        state is CodeVerifyingFailure)
                      Builder(
                        builder: (context) {
                          final email = state is CodeSendingSuccess
                              ? state.email
                              : (state as CodeVerifyingFailure).email;
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Opacity(
                                opacity: 0.6,
                                child: InkWell(
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      SendCodeEvent(email),
                                    );
                                  },
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
                          );
                        },
                      ),
                    const SizedBox(height: 35),
                    Builder(
                      builder: (context) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is CodeVerifyingFailure) {
                          return Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    SendCodeEvent(state.email),
                                  );
                                },
                                child: Text(
                                  'You can try to send it one more time',
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is CodeSendingSuccess) {
                          return VerifyButton(
                            codeController: _codeController,
                            email: state.email, // Pass email directly
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
