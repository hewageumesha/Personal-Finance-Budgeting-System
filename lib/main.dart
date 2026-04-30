import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:personal_finance_budgeting_system/features/analytics/presentation/providers/analytics_provider.dart';
import 'package:personal_finance_budgeting_system/features/authentication/data/repositories/auth_repository_Impl.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/sources/local/finance_local_data.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/features/profile/provider/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:personal_finance_budgeting_system/routes/app_router.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/db/db_helper.dart';
import 'features/analytics/data/repositories/analytics_repo_impl.dart';
import 'features/analytics/data/sources/local/analytics_local_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // this one required to create the db;
  final dbHelper = DatabaseHelper.instance;
  await dbHelper.db;


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

  final financeLocalData = FinanceLocalData();
  final authRepository = AuthRepositoryImpl(financeLocalData: financeLocalData);
  final financeRepository =
      FinanceRepositoryImpl(financeLocalData: financeLocalData);
  final analyticsLocalData = AnalyticsRepoImpl(localAnalyticsData: AnalyticsLocalData());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProviderr(authRepository)),
      ChangeNotifierProvider(create: (_) => SettingProvider()),
      ChangeNotifierProvider(create: (_) => FinanceProvider(financeRepository)),
      ChangeNotifierProvider(create: (_)=> AnalyticsProvider(analyticsLocalData))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProviderr>();
    final settingsProvider = context.watch<SettingProvider>();

    return MaterialApp.router(
      title: 'FinFlow',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      routerConfig: AppRouter.router(authProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
