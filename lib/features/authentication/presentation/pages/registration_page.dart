
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_button.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_text_field.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              labelText: 'Password',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: const Icon(Icons.visibility),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              labelText: 'Confirm Password',
              obscureText: true,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: const Icon(Icons.visibility),
            ),
            const SizedBox(height: 24.0),
            CustomButton(
              text: 'Register',
              onPressed: () {
                // Simulate registration
                GoRouter.of(context).go('/login');
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
