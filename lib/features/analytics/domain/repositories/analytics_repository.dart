import '../../data/models/category_summary.dart';

abstract class AnalyticsRepository {
  Future<List<CategorySummary>?> getCategoryBreakdown(String userUid);
  Future<CashFlowSummary> getMonthlyCashFlow(String userUid);
}