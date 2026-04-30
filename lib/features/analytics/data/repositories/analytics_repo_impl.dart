import 'package:personal_finance_budgeting_system/core/utils/category_icon_helper.dart';
import 'package:personal_finance_budgeting_system/features/analytics/data/models/category_summary.dart';
import 'package:personal_finance_budgeting_system/features/analytics/data/sources/local/analytics_local_data.dart';

import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepoImpl implements AnalyticsRepository {
  final AnalyticsLocalData localAnalyticsData;

  AnalyticsRepoImpl({required this.localAnalyticsData});

  @override
  Future<List<CategorySummary>?> getCategoryBreakdown(String userUid) async {
    final rawData = await localAnalyticsData.getCategoryExpenseSummary(userUid);
    return rawData
        ?.map((map) => CategorySummary(
              name: map['cname'],
              amount: (map['total_amount'] as num).toDouble().abs(),
              color: CategoryIconHelper.getIconColor(map['cname']),
            ))
        .toList();
  }

  @override
  Future<CashFlowSummary> getMonthlyCashFlow(String userUid) async {
    final data = await localAnalyticsData.getCashFlowSummary(userUid);
    if (data == null) return CashFlowSummary(income: 0, expense: 0);
    
    return CashFlowSummary(
      income: (data['income'] as num?)?.toDouble() ?? 0.0,
      expense: (data['expense'] as num?)?.toDouble().abs() ?? 0.0,
    );
  }
}
