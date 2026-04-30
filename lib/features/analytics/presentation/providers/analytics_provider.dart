import 'package:flutter/material.dart';

import '../../data/models/category_summary.dart';
import '../../data/repositories/analytics_repo_impl.dart';

class AnalyticsProvider extends ChangeNotifier {
  final AnalyticsRepoImpl _repository;

  AnalyticsProvider(this._repository);

  List<CategorySummary> _categoryData = [];
  CashFlowSummary _cashFlow = CashFlowSummary(income: 0, expense: 0);
  bool _isLoading = false;

  // Getters
  List<CategorySummary> get categoryData => _categoryData;

  CashFlowSummary get cashFlow => _cashFlow;

  bool get isLoading => _isLoading;

  Future<void> loadAnalytics(String userUid) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 🟢 Fix: Ensure we handle the results correctly and don't crash on results[1]
      final results = await Future.wait([
        _repository.getCategoryBreakdown(userUid),
        _repository.getMonthlyCashFlow(userUid),
      ]);

      _categoryData = (results[0] as List<CategorySummary>?) ?? [];
      _cashFlow = (results[1] as CashFlowSummary?) ?? CashFlowSummary(income: 0, expense: 0);
    } catch (e) {
      debugPrint("Analytics Load Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
