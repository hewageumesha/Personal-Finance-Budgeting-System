import 'package:flutter/material.dart';

import '../../../../shared/styles/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildActionButton(context, Icons.add, 'Add Income', () {
              /* TODO: Navigate to Add Income */
            }),
            _buildActionButton(context, Icons.remove, 'Add Expense', () {
              /* TODO: Navigate to Add Expense */
            }),
            _buildActionButton(context, Icons.swap_horiz, 'Transfer', () {
              /* TODO: Navigate to Transfer */
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          // Unique tag for each FloatingActionButton
          onPressed: onPressed,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.onPrimaryColor,
          mini: false,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
}
