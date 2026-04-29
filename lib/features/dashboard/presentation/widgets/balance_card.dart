import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/features/profile/provider/setting_provider.dart';
import '../../../../shared/styles/app_colors.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final settingProvider = context.watch<SettingProvider>();

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
              // '\$${provide.totalBalance?.toStringAsFixed(2)}',
              '${settingProvider.currencySymbol}${provider.getDisplayTotalBalance(settingProvider).toStringAsFixed(2)}',
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
                _buildBalanceDetail(context, 'Income','${settingProvider.currencySymbol}${provider.getDisplayIncome(settingProvider).toStringAsFixed(2)}',
                    Icons.arrow_upward),
                _buildBalanceDetail(context, 'Expenses',
                    '- ${settingProvider.currencySymbol}${provider.getDisplayExpense(settingProvider).toStringAsFixed(2)}',Icons.arrow_downward),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceDetail(
      BuildContext context, String title, String amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon,
                color: AppColors.onPrimaryColor.withOpacity(0.8), size: 20),
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
}
