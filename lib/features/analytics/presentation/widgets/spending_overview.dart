import 'package:flutter/material.dart';

import '../../../../shared/styles/app_colors.dart';

class SpendingOverview extends StatelessWidget {
  const SpendingOverview({super.key});

  @override
  Widget build(BuildContext context) {
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
