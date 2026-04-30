import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/analytics/domain/entities/category_entity.dart';

class CategorySummary extends CategoryEntity {
  CategorySummary(
      {required super.name, required super.amount, required super.color});
}

class CashFlowSummary extends CashFlowSummaryEntity {
  CashFlowSummary({required super.income, required super.expense});
}
