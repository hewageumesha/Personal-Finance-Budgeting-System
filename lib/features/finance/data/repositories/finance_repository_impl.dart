import 'package:personal_finance_budgeting_system/features/finance/data/model/transaction_model.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/repositories/finance_repository.dart';
import '../model/category_model.dart';
import '../sources/local/finance_local_data.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceLocalData financeLocalData;

  FinanceRepositoryImpl({required this.financeLocalData});

  @override
  Future<void> addCategory(CategoryEntity category) async {
    try {
      await financeLocalData
          .addLocalCategory(CategoryModel.fromEntity(category));
    } catch (e) {
      throw Exception('Failed to add Category');
    }
  }

  @override
  Future<void> removeCategory(String categoryId) async {
    try {
      await financeLocalData.removeLocalCategory(categoryId);
    } catch (e) {
      throw Exception('Failed to add remove');
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories(String uid) async {
    try {
      return await financeLocalData.getLocalCategories(uid);
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    try {
      return await financeLocalData
          .addLocalTransaction(TransactionModel.fromEntity(transaction));
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactions(String uid) async {
    try {
      return await financeLocalData.getLocalTransactions(uid);
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  @override
  Future<void> removeTransaction(String tid) async {
    try {
      await financeLocalData.removeLocalTransaction(tid);
    } catch (e) {
      throw Exception('Failed to add remove transaction');
    }
  }

  @override
  Future<double> getTotalBalance(String uid) {
    // TODO: implement getTotalBalance
    throw UnimplementedError();
  }
}
