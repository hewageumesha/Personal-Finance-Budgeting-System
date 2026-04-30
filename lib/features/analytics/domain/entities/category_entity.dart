import 'dart:ui';

class CategoryEntity {
  final String name;
  final double amount;
  final Color color;

  CategoryEntity(
      {required this.name, required this.amount, required this.color});
}

class CashFlowSummaryEntity {
  final double income;
  final double expense;

  CashFlowSummaryEntity({required this.income, required this.expense});
}
