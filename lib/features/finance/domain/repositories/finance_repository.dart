import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';

abstract class FinanceRepository {
  // category related methods
  Future<List<CategoryEntity>> getCategories(String uid);

  Future<void> addCategory(CategoryEntity category);

  Future<void> removeCategory(String categoryId);

  // transaction related methods
  Future<List<TransactionEntity>> getTransactions(String uid);

  Future<void> addTransaction(TransactionEntity transaction);

  Future<void> removeTransaction(String tid);

  Future<List<TransactionEntity>> getFilteredTransactions(
      String filter, String uid);

  // analytics
  Future<double> getTotalBalance(String uid);

  Future<double> getIncomeTotal(String uid);

  Future<double> getExpenseTotal(String uid);
}
