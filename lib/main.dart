import 'package:adevs/bloc/auth/auth_bloc.dart';
import 'package:adevs/bloc/token/token_bloc.dart';
import 'package:adevs/bloc/token/token_event.dart';
import 'package:adevs/bloc/token/token_state.dart';
import 'package:adevs/repositories/auth_repository.dart';
import 'package:adevs/repositories/token_repository.dart';
import 'package:adevs/screens/home_screen.dart';
import 'package:adevs/screens/login_screen.dart';
import 'package:adevs/services/api_service.dart';
import 'package:adevs/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService(
    baseUrl: 'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net',
  );

  final authRepo = AuthRepository(apiService);
  final tokenRepo = TokenRepository(
    TokenService(),
    apiService,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepo)),
        BlocProvider(create: (_) => TokenBloc(tokenRepo)),
      ],
      child: MaterialApp(
        home: FutureBuilder(
          future: TokenService().loadTokens(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final tokens = snapshot.data as TokenPair;
              return BlocBuilder<TokenBloc, TokenState>(
                builder: (context, state) {
                  if (state is! UserAuthenticated) {
                    context.read<TokenBloc>().add(
                      LoadUserEvent(tokens.jwt, tokens),
                    );
                  }
                  return const HomeScreen();
                },
              );
            }
            return const LoginScreen();
          },
        ),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    ),
  );
}