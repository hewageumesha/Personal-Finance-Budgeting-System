
import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: Center(
        child: Text(
          'Budget Management',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
