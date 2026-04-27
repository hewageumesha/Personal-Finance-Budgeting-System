import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:personal_finance_budgeting_system/core/utils/category_icon_helper.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:provider/provider.dart';
import '../../../../shared/styles/app_colors.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final transactions = provider.transactions;

    if (transactions.isEmpty) {
      return const Center(
        child: Text("No Transactions yet Today"),
      );
    }

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
          itemCount: transactions.length > 5 ? 5 : transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final isExpense = tx.amount < 0;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),

              // list Tile
              child: ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                //   child: Icon(
                //       index % 2 == 0 ? Icons.shopping_cart : Icons.restaurant,
                //       color: AppColors.primaryColor),
                // ),

                // Icon in the recent transaction
                leading: CircleAvatar(
                  backgroundColor:
                      CategoryIconHelper.getIconColor(tx.categoryName),
                  child: Icon(
                    // 🟢 Use the utility class helper to get the icon based on category
                    CategoryIconHelper.getIcon(tx.categoryName ?? ''),
                    color: AppColors.primaryColor,
                  ),
                ),

                // title: Text(index % 2 == 0 ? 'Groceries' : 'Dinner Out',
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium
                //         ?.copyWith(fontWeight: FontWeight.bold)),

                title: Text(tx.title ?? "Transaction",
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                subtitle: Text('${tx.categoryName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.grey600)),

                // trailing: Text(
                //   index % 2 == 0 ? '-\$55.00' : '-\$30.00',
                //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                //         color: index % 2 == 0
                //             ? AppColors.errorColor
                //             : AppColors.errorColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                // ),

                trailing: Text(
                  // 🟢 UX: Formatting with minus/plus and colors
                  "${isExpense ? '-' : '+'}\$${tx.amount.abs().toStringAsFixed(2)}",
                  style: TextStyle(
                      color: isExpense ? AppColors.errorColor : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),

                onTap: () {
                  /* TODO: Navigate to transaction detail */
                },
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
            child: Text('View All Transactions',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppColors.primaryColor)),
          ),
        ),
      ],
    );
  }
}
