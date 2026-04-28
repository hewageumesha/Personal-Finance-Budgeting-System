import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:csv/csv.dart';

class CsvHelper {

  static String generateFianceSummary({
    required double totalBalance,
    required double totalIncome,
    required double totalExpense,
    required List<TransactionEntity> transactions,
    required List<CategoryEntity> categories,
}){
    List<List<dynamic>> rows = [];
    rows.add(["FINANCIAL SUMMARY REPORT"]);
    rows.add(["Export Date",DateTime.now().toString()]);
    rows.add([]);// for empty row

    rows.add(["OVERALL TOTALS"]);
    rows.add(["Total Income", "Total Expenses", "Net Balance"]);
    rows.add([totalIncome, totalExpense, totalBalance]);
    rows.add([]);


    rows.add(["CATEGORY BREAKDOWN"]);
    rows.add(["Category", "Total Amount"]);
    for(var cat in categories){
      double catSum  = transactions.where((t) => t.cid == cat.cid).fold(0, (sum,t) => sum + t.amount);
      rows.add([cat.cname,catSum]);
    }

    rows.add([]);

    // 4. Detailed Logs
    rows.add(["TRANSACTION HISTORY"]);
    rows.add(["Date", "Title", "Category", "Amount (LKR)"]);
    for (var tx in transactions) {
      rows.add([tx.date, tx.title, tx.categoryName, tx.amount]);
    }

    return csv.encode(rows);

  }

}