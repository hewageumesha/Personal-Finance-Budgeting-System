import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_button.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_text_field.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/finflow_logo.dart';

import '../providers/auth_provider.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // 1. Define Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 2. Handle Registration Logic
  void _onRegisterPressed() async {
    final authProvider = context.read<AuthProviderr>();

    // Simple Validation
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    try {
      await authProvider.signUp(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (mounted) context.go('/dashboard');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll("Exception:", ""))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 3. Watch loading state from your Provider
    final isLoading = context.watch<AuthProviderr >().isLoading;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [AppColors.accentColor, AppColors.primaryColor],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  const FinFlowLogo(textColor: AppColors.onPrimaryColor, iconSize: 60, textSize: 48),
                  const SizedBox(height: 24.0),
                  Text(
                    'Join FinFlow Today!',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.onPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Create an account to start managing your finances smart',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.onPrimaryColor.withOpacity(0.8),
                    ),
                  ),
                  const Spacer(),
                  _buildRegistrationForm(context, isLoading),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context, bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Added Username field as required by your signUp method
          CustomTextField(
            controller: _usernameController,
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: const Icon(Icons.person, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Create a password',
            obscureText: true,
            prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: _confirmPasswordController,
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            obscureText: true,
            prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 24.0),

          // 4. Update Button to handle loading state
          CustomButton(
            text: isLoading ? 'Registering...' : 'Register',
            onPressed: isLoading ? null : _onRegisterPressed,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.onPrimaryColor,
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              'Already have an account? Login',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}