import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:personal_finance_budgeting_system/features/transactions/presentation/pages/transactions_page.dart';
import 'package:personal_finance_budgeting_system/features/analytics/presentation/pages/analytics_page.dart';
// import 'package:personal_finance_budgeting_system/features/budget/presentation/pages/budget_page.dart';
import 'package:personal_finance_budgeting_system/features/profile/presentation/pages/profile_page.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/scaffold_with_navbar.dart';

import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/authentication/presentation/screens/registration_page.dart';

import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter? _routerInstance;

  static GoRouter router(AuthProviderr authProvider) => _routerInstance ??= GoRouter(
        initialLocation: '/login',
        refreshListenable: authProvider,
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            builder: (context, state) => const RegistrationPage(),
          ),
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return ScaffoldWithNavBar(child: child);
            },
            routes: [
              GoRoute(
                path: '/dashboard',
                name: 'dashboard',
                builder: (context, state) =>
                    const DashboardPage(),
                routes: [
                  GoRoute(
                    path: 'transactions',
                    name: 'transactions',
                    builder: (context, state) => const TransactionsPage(),
                  ),
                  GoRoute(
                    path: 'analytics',
                    name: 'analytics',
                    builder: (context, state) => const AnalyticsPage(),
                  ),
                  GoRoute(
                    path: 'profile',
                    name: 'profile',
                    builder: (context, state) =>
                        ProfilePage(authProvider: authProvider),
                  ),
                  // GoRoute(
                  //   path: 'budget',
                  //   name: 'budget',
                  //   builder: (context, state) => const BudgetPage(),
                  // ),

                ],
              ),
            ],
          ),
        ],
        redirect: (context, state) {
          final loggedIn = authProvider.isAuthenticated;
          final loggingIn = state.matchedLocation == '/login' ||
              state.matchedLocation == '/register';

          // If not logged in, but trying to go to a protected route, redirect to login
          if (!loggedIn && !loggingIn) {
            return '/login';
          }
          // If logged in, but trying to go to login/register, redirect to dashboard
          if (loggedIn && loggingIn) {
            return '/dashboard';
          }

          // No redirect needed
          return null;
        },
        // Add error handling for unknown routes
        errorBuilder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(child: Text('Page not found: ${state.error}')),
        ),
      );
}
