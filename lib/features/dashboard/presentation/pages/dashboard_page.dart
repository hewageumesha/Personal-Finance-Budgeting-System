
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/routes/app_router.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to your Dashboard!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24.0),
            CustomButton(
              text: 'Logout',
              onPressed: () {
                AuthService.logout();
                GoRouter.of(context).go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
