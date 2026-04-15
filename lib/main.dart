import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/authentication/data/repositories/auth_repository_Impl.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:personal_finance_budgeting_system/routes/app_router.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/db/db_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print("firebase initialized");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Firebase failed to initialize: $e");
    }
  }

  final authRepository = AuthRepositoryImpl();
  final authProvider = AuthProviderr(authRepository);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProviderr(authRepository))
    ],
    child: MyApp(authProvider: authProvider),
  ));
}

class MyApp extends StatelessWidget {
  final AuthProviderr authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinFlow',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router(authProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
