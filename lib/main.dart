import 'package:adevs/core/internal/application.dart';
import 'package:adevs/core/utils/services/api_service.dart';
import 'package:adevs/core/utils/services/token_service.dart';
import 'package:adevs/features/login/presentation/bloc/auth_bloc.dart';
import 'package:adevs/features/verification/presentation/bloc/token_bloc.dart';
import 'package:adevs/repositories/auth_repository.dart';
import 'package:adevs/repositories/token_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService(
    baseUrl: 'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net',
  );

  final tokenService = TokenService();

  final authRepo = AuthRepository(
    apiService: apiService,
    tokenService: tokenService,
  );
  final tokenRepo = TokenRepository(
    tokenService: tokenService,
    apiService: apiService,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepo)),
        BlocProvider(create: (_) => TokenBloc(tokenRepo)),
      ],
      child: Application(),
    ),
  );
}
