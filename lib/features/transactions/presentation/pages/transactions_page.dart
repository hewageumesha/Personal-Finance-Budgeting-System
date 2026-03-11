import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _transactions = [
    {'name': 'Groceries', 'category': 'Food', 'amount': -55.00, 'date': '2024-03-10', 'type': 'expense'},
    {'name': 'Salary', 'category': 'Income', 'amount': 2500.00, 'date': '2024-03-09', 'type': 'income'},
    {'name': 'Coffee', 'category': 'Food', 'amount': -4.50, 'date': '2024-03-09', 'type': 'expense'},
    {'name': 'Rent', 'category': 'Housing', 'amount': -1200.00, 'date': '2024-03-05', 'type': 'expense'},
    {'name': 'Freelance Work', 'category': 'Income', 'amount': 800.00, 'date': '2024-03-03', 'type': 'income'},
    {'name': 'Books', 'category': 'Education', 'amount': -30.00, 'date': '2024-03-02', 'type': 'expense'},
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'All') {
      return _transactions;
    } else if (_selectedFilter == 'Income') {
      return _transactions.where((t) => t['type'] == 'income').toList();
    } else {
      return _transactions.where((t) => t['type'] == 'expense').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () { /* TODO: Navigate to Add Transaction Page */ },
            tooltip: 'Add New Transaction',
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
                _buildFilterChip('All'),
                _buildFilterChip('Income'),
                _buildFilterChip('Expenses'),
              ],
            ),
          ),
          Expanded(
            child: _filteredTransactions.isEmpty
                ? Center(
              child: Text(
                'No transactions found for this filter.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
                : ListView.builder(
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                final isExpense = transaction['type'] == 'expense';
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isExpense ? AppColors.errorColor.withOpacity(0.1) : AppColors.successColor.withOpacity(0.1),
                      child: Icon(
                        isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isExpense ? AppColors.errorColor : AppColors.successColor,
                      ),
                    ),
                    title: Text(transaction['name']),
                    subtitle: Text('${transaction['category']} - ${transaction['date']}'),
                    trailing: Text(
                      '${isExpense ? '-' : '+'}\$${transaction['amount'].abs().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isExpense ? AppColors.errorColor : AppColors.successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () { /* TODO: Navigate to transaction detail */ },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: AppColors.primaryColor.withOpacity(0.2),
      checkmarkColor: AppColors.primaryColor,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: _selectedFilter == label ? AppColors.primaryColor : AppColors.onBackgroundColor,
      ),
    );
  }
}
