import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/login/presentation/bloc/auth_event.dart';
import 'package:adevs/features/login/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CodeSendingSuccess) {
          context.go('/verification');
        }
      },
      builder: (context, state) {
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
                        Text('Login'),
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
                          'Enter your email address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffF2796B),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 31),
                    TextField(
                      controller: _emailController,
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
                    SizedBox(height: 11),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Opacity(
                          opacity: 0.6,
                          child: Text(
                            'Change Email?',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(
                            SendCodeEvent(_emailController.text.trim()),
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
                      ),
                    SizedBox(height: 42),
                    Divider(color: Color(0xffA39797)),
                    SizedBox(height: 42),
                    Opacity(
                      opacity: 0.6,
                      child: RichText(
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "You Dont't have an account ? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
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
