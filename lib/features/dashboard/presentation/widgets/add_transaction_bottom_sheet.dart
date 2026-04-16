import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  bool isExpense;

  AddTransactionBottomSheet({super.key, required this.isExpense});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final financeProvider = context.watch<FinanceProvider>();
    final themeColor = widget.isExpense ? Colors.red : Colors.green;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom +
            20, // Move up for keyboard
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isExpense ? 'Add New Expense' : 'Add New Income',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),

          // amount
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.attach_money,
                color: themeColor,
              ),
              labelText: "Amount",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // Description
          TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description_outlined, color: themeColor),
                labelText: "Description",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),

          const SizedBox(
            height: 20,
          ),

          //   category Selector
          const Text(
            "Select Category",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
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
                      label: Text(
                        category.cname,
                      ),
                      selected: isSelected,
                      onSelected: (select) {
                        setState(() =>
                            _selectedCategoryId = category.cid as String?);
                      },
                    ),
                  );
                }),
          ),

          const SizedBox(
            height: 10,
          ),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Save Transaction',
                  style: TextStyle(color: Colors.white) ,
                ),),

          )
        ],
      ),
    );
  }
}
