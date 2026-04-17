import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';

import '../../domain/repositories/finance_repository.dart';

class FinanceProvider extends ChangeNotifier {
  final FinanceRepository _financeRepository;

  List<TransactionEntity> transactions = [];
  List<CategoryEntity> categories = [];
  double? _totalBalance;
  double _income = 0.0;
  double _expense = 0.0;
  String? _errMessage;
  bool _isLoading = false;

  // constructor
  FinanceProvider(this._financeRepository);

  //Getters
  List<TransactionEntity> get getTransactions => transactions;

  List<CategoryEntity> get getCategories => categories;

  bool get isLoading => _isLoading;

  bool get error => _errMessage != null;

  double? get totalBalance => _totalBalance;

  double get income => _income;

  double get expense => _expense;

  // Methods
  Future<void> loadFinanceData(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      final [trans, cats, balance, income, expense] = await Future.wait([
        _financeRepository.getTransactions(uid),
        _financeRepository.getCategories(uid),
        _financeRepository.getTotalBalance(uid),
        _financeRepository.getIncomeTotal(uid),
        _financeRepository.getExpenseTotal(uid),
      ]);

      // 🟢 The and MUST be here to "unpack" the results
      transactions = trans as List<TransactionEntity>;
      categories = cats as List<CategoryEntity>;
      _totalBalance = balance as double;
      _income = income as double;
      _expense = expense as double;

      print(transactions);
    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ FinanceProvider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(TransactionEntity transaction) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _financeRepository.addTransaction(transaction);

      // refresh
      await loadFinanceData(transaction.userUid);
    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ Something wrong with adding transaction $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
