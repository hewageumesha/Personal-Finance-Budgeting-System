import 'dart:io';
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

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  final db = await _databaseHelper.db;

  if (db != null) {
    await _databaseHelper.seedMockUser();
    await _databaseHelper.verifyTables();
  }
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("firebase initalied");
  } catch (e) {
    print("Firebase failed to initialize: $e");
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

//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:personal_finance_budgeting_system/features/authentication/presentation/screens/registration_page.dart';
// import 'package:provider/provider.dart';
//
// // Your imports (Double check these paths match your project)
// import 'features/authentication/presentation/screens/login_screen.dart';
// import 'firebase_options.dart';
// import 'features/authentication/data/repositories/auth_repository_impl.dart';
// import 'features/authentication/presentation/providers/auth_provider.dart';
//
// import 'features/dashboard/presentation/pages/dashboard_page.dart';
// import 'shared/styles/app_theme.dart';
//
// void main() async {
//   // 1. MUST BE FIRST: Initialize the Flutter engine binding
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // 2. Initialize Firebase (Member 4)
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     debugPrint("Firebase init failed: $e");
//   }
//
//   // 3. Setup Repository and Provider
//   final authRepository = AuthRepositoryImpl();
//   final authProvider = AuthProvider(authRepository);
//
//   runApp(
//     ChangeNotifierProvider.value(
//       value: authProvider,
//       child: MyApp(authProvider: authProvider),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   final AuthProvider authProvider;
//   const MyApp({super.key, required this.authProvider});
//
//   @override
//   Widget build(BuildContext context) {
//     // 4. Configure Router with Redirect Logic
//     final GoRouter _router = GoRouter(
//       initialLocation: '/login',
//       refreshListenable: authProvider, // 👈 Router watches AuthProvider for changes
//       redirect: (context, state) {
//         final bool loggedIn = authProvider.isAuthenticated;
//         final bool isLoggingIn = state.matchedLocation == '/login';
//         final bool isRegistering = state.matchedLocation == '/register';
//
//         // Redirect logic for Security & UX
//         if (!loggedIn && !isLoggingIn && !isRegistering) return '/login';
//         if (loggedIn && (isLoggingIn || isRegistering)) return '/dashboard';
//
//         return null; // No redirect needed
//       },
//       routes: [
//         GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
//         GoRoute(path: '/register', builder: (context, state) => const RegistrationPage()),
//       ],
//     );
//
//     return MaterialApp.router(
//       title: 'FinFlow',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       routerConfig: _router,
//     );
//   }
// }
