import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_budgeting_system/core/utils/string_utils.dart';
import 'package:personal_finance_budgeting_system/features/dashboard/presentation/widgets/add_transaction_bottom_sheet.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/features/profile/provider/setting_provider.dart';
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
        final uid = context
            .read<AuthProviderr>()
            .user
            ?.uid;

        context
            .read<FinanceProvider>()
            .changeFilter(TransactionFilter.all, uid!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final settingProvider = context.watch<SettingProvider>();
    final transactions = provider.getFilteredTransactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () {
              context.read<FinanceProvider>().exportTransactionsToCsv();
            },
            tooltip: 'Summary',
          ),
        ],
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
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
            )
                : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                final isExpense = tx.amount < 0;
                
                // 🟢 Fix: Generic conversion logic for all non-LKR currencies (USD, EUR)
                final double displayAmount =
                settingProvider.selectedCurrency != AppCurrency.LKR
                    ? tx.amount.abs() / settingProvider.exchangeRate
                    : tx.amount.abs();

                // 🟢 Format date and time
                final formattedDate = DateFormat('MMM dd, yyyy • hh:mm a').format(tx.date);

                return Dismissible(
                  key: Key(tx.tid),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await _showDeleteConfirmation(context);
                  },
                  onDismissed: (direction) {
                    provider.deleteTransaction(tx.tid, tx.userUid);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${StringUtils.capitalizeWords(
                                  tx.title)} deleted')),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.errorColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
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
                          CategoryIconHelper.getIcon(
                              tx.categoryName ?? ''),
                          color: CategoryIconHelper.getIconColor(
                              tx.categoryName),
                        ),
                      ),
                      title: Text(StringUtils.capitalizeWords(tx.title),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${tx.categoryName} • $formattedDate',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.grey600)),
                          if (tx.locationName != null && tx.locationName!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 10, color: Colors.blueGrey),
                                  const SizedBox(width: 2),
                                  Text(
                                    tx.locationName!,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                          // 🟢 Receipt View Button
                          if (tx.receiptImagePath != null && tx.receiptImagePath!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () => _showReceiptDialog(context, tx.receiptImagePath!),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.receipt_long_outlined,
                                          size: 16, color: AppColors.primaryColor),
                                      SizedBox(width: 6),
                                      Text(
                                        'View Receipt',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      trailing: Text(
                        '${isExpense ? '-' : '+'}${settingProvider
                            .currencySymbol}${displayAmount.toStringAsFixed(
                            2)}',
                        style: Theme
                            .of(context)
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
                        final bool currentlyIsExpense = tx.amount < 0;

                        showModalBottomSheet(context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) =>
                                AddTransactionBottomSheet(transaction: tx, isExpense: currentlyIsExpense,));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showReceiptDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Transaction Receipt', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Receipt image not found.', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Delete Transaction'),
            content: const Text(
                'Are you sure you want to permanently remove this transaction?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false), // User cancels
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true), // User confirms
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.errorColor),
                child: const Text('DELETE'),
              ),
            ],
          ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label,
      TransactionFilter filter, FinanceProvider provider) {
    final isSelected = provider.transactionFilter == filter;
    final uid = context
        .watch<AuthProviderr>()
        .user!
        .uid;

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
        isSelected ? AppColors.primaryColor : null, // Removed hardcoded onBackgroundColor
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
