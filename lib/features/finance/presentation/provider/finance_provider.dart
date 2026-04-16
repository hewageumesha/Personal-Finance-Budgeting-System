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
  String? _errMessage;
  bool _isLoading = false;

  // constructor
  FinanceProvider(this._financeRepository);

  //Getters
  List<TransactionEntity> get getTransactions => transactions;

  List<CategoryEntity> get getCategories => categories;

  bool get isLoading => _isLoading;

  bool get error => _errMessage != null;

  Future<void> loadFinanceData(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      final [trans,cats] = await Future.wait([
        _financeRepository.getTransactions(uid),
        _financeRepository.getCategories(uid)
      ]);

      // 🟢 The and MUST be here to "unpack" the results
      transactions = trans as List<TransactionEntity>;
      categories = cats as List<CategoryEntity>;


    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ FinanceProvider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
