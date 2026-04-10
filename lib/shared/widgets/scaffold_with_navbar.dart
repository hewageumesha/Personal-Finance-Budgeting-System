
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(context, idx),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    // Use GoRouterState.of(context).uri.toString() instead of .location
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/dashboard')) {
      return 0;
    } else if (location.startsWith('/transactions')) {
      return 1;
    } else if (location.startsWith('/analytics')) {
      return 2;
    } else if (location.startsWith('/budget')) {
      return 3;
    } else if (location.startsWith('/profile')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int idx) {
    switch (idx) {
      case 0:
        GoRouter.of(context).go('/dashboard');
        break;
      case 1:
        GoRouter.of(context).go('/dashboard/transactions');
        break;
      case 2:
        GoRouter.of(context).go('/dashboard/analytics');
        break;
      case 3:
        GoRouter.of(context).go('/dashboard/budget');
        break;
      case 4:
        GoRouter.of(context).go('/dashboard/profile');
        break;
    }
  }
}
