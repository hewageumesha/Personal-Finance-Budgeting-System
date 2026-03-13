import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/routes/app_router.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/custom_button.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/finflow_logo.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FinFlowLogo(textColor: AppColors.onPrimaryColor, iconSize: 28, textSize: 22),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthService.logout();
              GoRouter.of(context).go('/login');
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, User!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onBackgroundColor,
                  ),
            ),
            const SizedBox(height: 24.0),
            _buildBalanceCard(context),
            const SizedBox(height: 24.0),
            _buildQuickActions(context),
            const SizedBox(height: 24.0),
            _buildRecentTransactions(context),
            const SizedBox(height: 24.0),
            _buildSpendingOverview(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.successColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onPrimaryColor.withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '\$12,345.67',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.onPrimaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceDetail(context, 'Income', '\$5,000.00', Icons.arrow_upward),
                _buildBalanceDetail(context, 'Expenses', '\$2,500.00', Icons.arrow_downward),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceDetail(BuildContext context, String title, String amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.onPrimaryColor.withOpacity(0.8), size: 20),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onPrimaryColor.withOpacity(0.8),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.onPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(context, Icons.add, 'Add Income', () { /* TODO: Navigate to Add Income */ }),
            _buildActionButton(context, Icons.remove, 'Add Expense', () { /* TODO: Navigate to Add Expense */ }),
            _buildActionButton(context, Icons.swap_horiz, 'Transfer', () { /* TODO: Navigate to Transfer */ }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label, // Unique tag for each FloatingActionButton
          onPressed: onPressed,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.onPrimaryColor,
          mini: false,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 10.0),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onBackgroundColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
        ),
        const SizedBox(height: 16.0),
        // Placeholder for a list of recent transactions
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Show 3 recent transactions as example
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Icon(index % 2 == 0 ? Icons.shopping_cart : Icons.restaurant, color: AppColors.primaryColor),
                ),
                title: Text(index % 2 == 0 ? 'Groceries' : 'Dinner Out', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(index % 2 == 0 ? 'Food & Drinks' : 'Dining', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
                trailing: Text(
                  index % 2 == 0 ? '-\$55.00' : '-\$30.00',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: index % 2 == 0 ? AppColors.errorColor : AppColors.errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onTap: () { /* TODO: Navigate to transaction detail */ },
              ),
            );
          },
        ),
        const SizedBox(height: 10.0),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              GoRouter.of(context).go('/dashboard/transactions');
            },
            child: Text('View All Transactions', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primaryColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildSpendingOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spending Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
        ),
        const SizedBox(height: 16.0),
        // Placeholder for a chart or spending summary
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Chart Placeholder (e.g., Pie Chart)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.grey600,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
