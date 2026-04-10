import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () { /* TODO: Navigate to Add Budget Item Page */ },
            tooltip: 'Add New Budget',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Budget Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildBudgetSummaryCard(context),
            const SizedBox(height: 24.0),
            Text(
              'Budget Categories',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildBudgetCategory(context, 'Food', 500, 450, Icons.fastfood, AppColors.warningColor),
            _buildBudgetCategory(context, 'Housing', 1500, 1200, Icons.home, AppColors.infoColor),
            _buildBudgetCategory(context, 'Transportation', 200, 180, Icons.directions_car, AppColors.primaryColor),
            _buildBudgetCategory(context, 'Entertainment', 300, 320, Icons.movie, AppColors.errorColor),
            _buildBudgetCategory(context, 'Savings', 400, 400, Icons.savings, AppColors.successColor),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetSummaryCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.infoColor, AppColors.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Remaining',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.onPrimaryColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '\$750.00 / \$3000.00',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.onPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            LinearProgressIndicator(
              value: 0.75, // Example: 75% of budget spent
              backgroundColor: AppColors.onPrimaryColor.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.onPrimaryColor),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '75% Spent',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onPrimaryColor.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCategory(BuildContext context, String category, double budgeted, double spent, IconData icon, Color color) {
    double progress = spent / budgeted;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onBackgroundColor,
                    ),
                  ),
                ),
                Text(
                  '\$${spent.toStringAsFixed(2)} / \$${budgeted.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.grey700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0), // Ensure value is between 0 and 1
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                progress > 1.0 ? 'Over budget!' : '${(progress * 100).toStringAsFixed(0)}% Spent',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: progress > 1.0 ? AppColors.errorColor : AppColors.grey600,
                  fontWeight: progress > 1.0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
