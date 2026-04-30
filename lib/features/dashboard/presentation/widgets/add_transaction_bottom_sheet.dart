import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/analytics/presentation/providers/analytics_provider.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:personal_finance_budgeting_system/features/profile/provider/setting_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  final bool isExpense;
  final TransactionEntity? transaction;

  const AddTransactionBottomSheet(
      {super.key, required this.isExpense, this.transaction});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final settings = context.read<SettingProvider>();
      double displayAmount = widget.transaction!.amount.abs();
      
      if (settings.selectedCurrency != AppCurrency.LKR) {
        displayAmount = displayAmount / settings.exchangeRate;
      }

      _amountController.text = displayAmount.toStringAsFixed(2);
      _titleController.text = widget.transaction!.title;
      _descriptionController.text = widget.transaction!.description ?? '';
      _selectedCategoryId = widget.transaction!.cid;
    }
  }

  @override
  Widget build(BuildContext context) {
    final financeProvider = context.watch<FinanceProvider>();
    final settingProvider = context.watch<SettingProvider>();
    final analyticsProvider = context.read<AnalyticsProvider>();

    final isEditing = widget.transaction != null;
    final themeColor = widget.isExpense ? Colors.red : Colors.green;
    final uid = context.read<AuthProviderr>().user?.uid;

    IconData currencyIcon;
    switch (settingProvider.selectedCurrency) {
      case AppCurrency.LKR:
        currencyIcon = Icons.payments_outlined;
        break;
      case AppCurrency.USD:
        currencyIcon = Icons.attach_money;
        break;
      case AppCurrency.EUR:
        currencyIcon = Icons.euro_rounded;
        break;
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing
                ? 'Edit Transaction'
                : widget.isExpense
                    ? 'Add New Expense'
                    : 'Add New Income',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(currencyIcon, color: themeColor),
              labelText: "Amount In ${settingProvider.selectedCurrency.name}",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.label_outline, color: themeColor),
                labelText: "Title",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description_outlined, color: themeColor),
                labelText: "Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),

          const SizedBox(height: 20),

          const Text("Select Category", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: financeProvider.getCategories.length,
                itemBuilder: (context, index) {
                  final category = financeProvider.getCategories[index];
                  final isSelected = _selectedCategoryId == category.cid;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category.cname),
                      selected: isSelected,
                      onSelected: (select) {
                        setState(() => _selectedCategoryId = category.cid);
                      },
                    ),
                  );
                }),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (financeProvider.isLoading || _selectedCategoryId == null) ? null : () async {
                if (_amountController.text.isEmpty || _titleController.text.isEmpty) {
                  return;
                }

                if (isEditing) {
                  final updatedTx = widget.transaction!.copyWith(
                    title: _titleController.text,
                    amount: double.parse(_amountController.text) * (widget.isExpense ? -1 : 1),
                    description: _descriptionController.text,
                    cid: _selectedCategoryId!,
                  );

                  await financeProvider.updateTransaction(updatedTx, settingProvider);
                } else {
                  final tx = TransactionEntity(
                      tid: 'tx${DateTime.now().millisecondsSinceEpoch}',
                      amount: double.parse(_amountController.text) * (widget.isExpense ? -1 : 1),
                      cid: _selectedCategoryId!,
                      date: DateTime.now(),
                      description: _descriptionController.text,
                      userUid: uid!,
                      title: _titleController.text);

                  await financeProvider.addTransaction(tx, settingProvider);
                }

                // 🟢 Refresh analytics so pie charts update immediately
                if (uid != null) {
                  await analyticsProvider.loadAnalytics(uid);
                }

                if (mounted) Navigator.pop(context);
              },
              child: financeProvider.isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(isEditing ? 'Update Transaction' : 'Save Transaction', style: const TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
