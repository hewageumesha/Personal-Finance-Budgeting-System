
import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spending Trends',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildChartPlaceholder(context, 'Line Chart: Spending over time'),
            const SizedBox(height: 24.0),
            Text(
              'Category-wise Breakdown',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildChartPlaceholder(context, 'Pie Chart: Expenses by Category'),
            const SizedBox(height: 24.0),
            Text(
              'Financial Insights',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onBackgroundColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInsightCard(context, 'You spent 20% more on food this month.', Icons.fastfood, AppColors.errorColor),
            _buildInsightCard(context, 'You saved 15% more than last month!', Icons.savings, AppColors.successColor),
            _buildInsightCard(context, 'Consider reviewing your subscription expenses.', Icons.subscriptions, AppColors.warningColor),
          ],
        ),
      ),
    );
  }

  Widget _buildChartPlaceholder(BuildContext context, String title) {
    return Container(
      height: 250,
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
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.grey600,
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, String insight, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                insight,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.onBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
