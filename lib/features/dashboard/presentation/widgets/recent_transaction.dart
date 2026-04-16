import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/styles/app_colors.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Icon(
                      index % 2 == 0 ? Icons.shopping_cart : Icons.restaurant,
                      color: AppColors.primaryColor),
                ),
                title: Text(index % 2 == 0 ? 'Groceries' : 'Dinner Out',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(index % 2 == 0 ? 'Food & Drinks' : 'Dining',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.grey600)),
                trailing: Text(
                  index % 2 == 0 ? '-\$55.00' : '-\$30.00',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: index % 2 == 0
                            ? AppColors.errorColor
                            : AppColors.errorColor,
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
