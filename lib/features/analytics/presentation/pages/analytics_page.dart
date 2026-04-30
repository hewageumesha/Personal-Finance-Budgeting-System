import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:personal_finance_budgeting_system/core/utils/category_icon_helper.dart';
import 'package:personal_finance_budgeting_system/core/utils/string_utils.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
      ),
      body: Consumer<FinanceProvider>(
        builder: (context, financeProvider, child) {
          if (financeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final transactions = financeProvider.transactions;
          final categories = financeProvider.categories;

          if (transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart_outline, size: 64, color: AppColors.grey600),
                  const SizedBox(height: 16),
                  const Text('No transaction data available yet.'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Spending Trend (Last 7 Days)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackgroundColor,
                      ),
                ),
                const SizedBox(height: 16.0),
                _buildBarChart(context, transactions, categories),
                const SizedBox(height: 32.0),
                Text(
                  'Expense Breakdown',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackgroundColor,
                      ),
                ),
                const SizedBox(height: 16.0),
                _buildPieChart(context, transactions, categories),
                const SizedBox(height: 32.0),
                Text(
                  'Financial Insights',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackgroundColor,
                      ),
                ),
                const SizedBox(height: 16.0),
                _buildInsightsList(context, transactions, categories),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, List<TransactionEntity> transactions, List<CategoryEntity> categories) {
    final now = DateTime.now();
    final last7Days = List.generate(7, (index) => now.subtract(Duration(days: index))).reversed.toList();
    
    final expenseCids = categories
        .where((c) => c.cType == CategoryType.expense)
        .map((c) => c.cid)
        .toSet();

    List<BarChartGroupData> barGroups = [];
    double maxAmount = 0;

    for (int i = 0; i < last7Days.length; i++) {
      double dayTotal = transactions
          .where((t) =>
              expenseCids.contains(t.cid) &&
              t.date.year == last7Days[i].year &&
              t.date.month == last7Days[i].month &&
              t.date.day == last7Days[i].day)
          .fold(0.0, (sum, t) => sum + t.amount.abs());

      if (dayTotal > maxAmount) maxAmount = dayTotal;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: dayTotal,
              color: AppColors.primaryColor,
              width: 18,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxAmount == 0 ? 100 : maxAmount * 1.2,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final date = last7Days[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${date.day}/${date.month}', style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildPieChart(BuildContext context, List<TransactionEntity> transactions, List<CategoryEntity> categories) {
    final expenseCategories = categories.where((c) => c.cType == CategoryType.expense).toList();
    Map<String, double> categoryTotals = {};

    for (var cat in expenseCategories) {
      double total = transactions
          .where((t) => t.cid == cat.cid)
          .fold(0.0, (sum, t) => sum + t.amount.abs());
      if (total > 0) {
        categoryTotals[cat.cname] = total;
      }
    }

    if (categoryTotals.isEmpty) {
      return Container(
        height: 250,
        alignment: Alignment.center,
        child: const Text('No expense data to display.'),
      );
    }

    List<PieChartSectionData> sections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.value > (categoryTotals.values.reduce((a, b) => a + b) * 0.1) 
            ? '${StringUtils.capitalizeWords(entry.key)}' 
            : '',
        color: CategoryIconHelper.getIconColor(entry.key),
        radius: 60,
        titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 50,
                sectionsSpace: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: categoryTotals.keys.map((name) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 10, height: 10, color: CategoryIconHelper.getIconColor(name)),
                  const SizedBox(width: 4),
                  Text(StringUtils.capitalizeWords(name), style: const TextStyle(fontSize: 10)),
                ],
              )).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInsightsList(BuildContext context, List<TransactionEntity> transactions, List<CategoryEntity> categories) {
    double totalIncome = transactions
        .where((t) => categories.any((c) => c.cid == t.cid && c.cType == CategoryType.income))
        .fold(0.0, (sum, t) => sum + t.amount.abs());
        
    double totalExpense = transactions
        .where((t) => categories.any((c) => c.cid == t.cid && c.cType == CategoryType.expense))
        .fold(0.0, (sum, t) => sum + t.amount.abs());

    return Column(
      children: [
        if (totalExpense > totalIncome && totalIncome > 0)
          _buildInsightCard(context, 'Your expenses exceed your income this month!', Icons.warning_rounded, AppColors.errorColor),
        if (totalIncome > totalExpense)
          _buildInsightCard(context, 'Great! You have saved money this month.', Icons.savings_rounded, AppColors.successColor),
        _buildInsightCard(context, 'You have recorded ${transactions.length} transactions total.', Icons.receipt_long_rounded, AppColors.infoColor),
      ],
    );
  }

  Widget _buildInsightCard(BuildContext context, String insight, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                insight,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
