import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_button.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_text_field.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/finflow_logo.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  AppColors.accentColor,
                  AppColors.primaryColor,
                ],
              ),
            ),
          ),
          // Content
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
                  _buildRegistrationForm(context),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
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
          CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            labelText: 'Password',
            hintText: 'Create a password',
            obscureText: true,
            prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
            suffixIcon: const Icon(Icons.visibility, color: AppColors.grey600),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            obscureText: true,
            prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
            suffixIcon: const Icon(Icons.visibility, color: AppColors.grey600),
          ),
          const SizedBox(height: 24.0),
          CustomButton(
            text: 'Register',
            onPressed: () {
              // Simulate registration
              GoRouter.of(context).go('/login');
            },
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.onPrimaryColor,
          ),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/login');
            },
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
