import '../../../../../core/db/db_helper.dart';

class AnalyticsLocalData {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>?> getCategoryExpenseSummary(String userUid) async {
    final db = await _databaseHelper.db;
    return await db?.rawQuery('''
      SELECT c.cname, SUM(t.amount) as total_amount
      FROM transactions t
      INNER JOIN categories c ON t.category_id = c.cid
      WHERE t.user_uid = ? AND LOWER(c.cType) = 'expense'
      GROUP BY c.cname
      HAVING total_amount <> 0
      ORDER BY ABS(total_amount) DESC
    ''', [userUid]);
  }

  Future<Map<String, dynamic>?> getCashFlowSummary(String userUid) async {
    final db = await _databaseHelper.db;
    final results = await db?.rawQuery('''
      SELECT 
        SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) as income,
        SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END) as expense
      FROM transactions
      WHERE user_uid = ?
    ''', [userUid]);
    return results?.isNotEmpty == true ? results!.first : null;
  }
}
