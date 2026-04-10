import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/routes/app_router.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24.0),
            _buildAccountSettings(context),
            const SizedBox(height: 24.0),
            _buildAppPreferences(context),
            const SizedBox(height: 24.0),
            _buildSupportSection(context),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  AuthService.logout();
                  GoRouter.of(context).go('/login');
                },
                icon: const Icon(Icons.logout, color: AppColors.onPrimaryColor),
                label: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primaryColor.withOpacity(0.2),
            child: Icon(Icons.person, size: 70, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Umesha 1096',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onBackgroundColor,
            ),
          ),
          Text(
            'umesha.1096@example.com',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: 16.0),
          OutlinedButton.icon(
            onPressed: () { /* TODO: Edit Profile */ },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onBackgroundColor,
        ),
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Account Settings'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildProfileListItem(context, Icons.lock, 'Change Password', () { /* TODO: Navigate to Change Password */ }),
              _buildProfileListItem(context, Icons.currency_exchange, 'Currency Preferences', () { /* TODO: Navigate to Currency Preferences */ }),
              _buildProfileListItem(context, Icons.notifications, 'Notification Settings', () { /* TODO: Navigate to Notification Settings */ }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppPreferences(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'App Preferences'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildProfileListItem(context, Icons.dark_mode, 'Dark Mode', () { /* TODO: Toggle Dark Mode */ }, showSwitch: true),
              _buildProfileListItem(context, Icons.language, 'Language', () { /* TODO: Navigate to Language Settings */ }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Support'),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildProfileListItem(context, Icons.help_outline, 'Help & FAQ', () { /* TODO: Navigate to Help */ }),
              _buildProfileListItem(context, Icons.feedback, 'Send Feedback', () { /* TODO: Navigate to Feedback */ }),
              _buildProfileListItem(context, Icons.info_outline, 'About App', () { /* TODO: Navigate to About */ }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileListItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {bool showSwitch = false}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: showSwitch
          ? Switch(
        value: false, // TODO: Implement actual state management for switch
        onChanged: (bool value) { /* TODO: Handle switch toggle */ },
        activeColor: AppColors.primaryColor,
      )
          : const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.grey600),
      onTap: onTap,
    );
  }
}

