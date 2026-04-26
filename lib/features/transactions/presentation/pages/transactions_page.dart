import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/category_icon_helper.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final uid = context.read<AuthProviderr>().user?.uid;

        context
            .read<FinanceProvider>()
            .changeFilter(TransactionFilter.all, uid!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final transactions = provider.getFilteredTransactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_circle_outline),
        //     onPressed: () {
        //
        //    },
        //     tooltip: 'Add New Transaction',
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFilterChip(
                    context, 'All', TransactionFilter.all, provider),
                _buildFilterChip(
                    context, 'Income', TransactionFilter.income, provider),
                _buildFilterChip(
                    context, 'Expense', TransactionFilter.expense, provider),
              ],
            ),
          ),
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions found for this filter.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      final isExpense = tx.amount < 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: CategoryIconHelper.getIconColor(
                                    tx.categoryName ?? '')
                                .withOpacity(0.1),
                            child: Icon(
                              CategoryIconHelper.getIcon(tx.categoryName ?? ''),
                              color: CategoryIconHelper.getIconColor(
                                  tx.categoryName),
                            ),
                          ),
                          title: Text(tx.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${tx.categoryName} - ${tx.date}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.grey600)),
                          trailing: Text(
                            '${isExpense ? '-' : '+'}\$${tx.amount.abs().toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: isExpense
                                      ? AppColors.errorColor
                                      : AppColors.successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onTap: () {
                            /* TODO: Navigate to transaction detail */
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label,
      TransactionFilter filter, FinanceProvider provider) {
    final isSelected = provider.transactionFilter == filter;
    final uid = context.watch<AuthProviderr>().user!.uid;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        provider.changeFilter(filter, uid);
      },
      selectedColor: AppColors.primaryColor.withOpacity(0.2),
      checkmarkColor: AppColors.primaryColor,
      labelStyle: TextStyle(
        color:
            isSelected ? AppColors.primaryColor : AppColors.onBackgroundColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
