import 'package:personal_finance_budgeting_system/features/finance/data/model/transaction_model.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/repositories/finance_repository.dart';
import 'package:personal_finance_budgeting_system/features/finance/presentation/provider/finance_provider.dart';
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
      throw Exception('Failed to fetch categories $e');
    }
  }

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    try {
      return await financeLocalData
          .addLocalTransaction(TransactionModel.fromEntity(transaction));
    } catch (e) {
      throw Exception('failed to add transaction');
    }
  }

  @override
  Future<List<TransactionEntity>> getTransactions(String uid) async {
    try {
      return await financeLocalData.getLocalTransactions(uid);
    } catch (e) {
      throw Exception('Failed to fetch transactions $e');
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
  Future<double> getTotalBalance(String uid) async {
    try {
      return await financeLocalData.getLocalTotalBalance(uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<double> getExpenseTotal(String uid) async {
    try {
      return await financeLocalData.getLocalExpenseTotal(uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<double> getIncomeTotal(String uid) async {
    try {
      return await financeLocalData.getLocalIncomeTotal(uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TransactionEntity>> getFilteredTransactions(String filter,
      String uid) async {
    try {
      return await financeLocalData.getFilteredTransactions(uid, filter);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    try{
      return await financeLocalData.updateLocalTransaction(TransactionModel.fromEntity(transaction));
    }catch(e){
      throw  Exception('Failed to update transaction: $e');
    }
  }


}
