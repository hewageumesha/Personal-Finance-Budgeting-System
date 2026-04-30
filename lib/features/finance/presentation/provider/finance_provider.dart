import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/core/utils/csv_helper.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';
import 'package:personal_finance_budgeting_system/features/location/location_service.dart';
import 'package:personal_finance_budgeting_system/features/profile/provider/setting_provider.dart';
import '../../domain/repositories/finance_repository.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';


class FinanceProvider extends ChangeNotifier {
  final FinanceRepository _financeRepository;

  TransactionFilter _selectedFilter = TransactionFilter.all;

  List<TransactionEntity> transactions = [];
  List<CategoryEntity> categories = [];
  List<TransactionEntity> _filteredTransactions = [];
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

  TransactionFilter get transactionFilter => _selectedFilter;

  List<TransactionEntity> get getFilteredTransactions => _filteredTransactions;

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

      // 🟢 Fix: Refresh filtered transactions too
      await changeFilter(_selectedFilter, uid);

      print(transactions);
    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ FinanceProvider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(
      TransactionEntity transaction, SettingProvider settings) async {
    _isLoading = true;
    notifyListeners();

    try {
      double amountLkr = transaction.amount;
      double? lat;
      double? lng;
      String? locName;


      try {
        final locService = LocationService();
        final position = await locService.fetchCurrentLocation();
        if (position != null) {
          lat = position.latitude;
          lng = position.longitude;
          locName = await locService.getLocationName(lat, lng);
        }
      } catch (e) {
        debugPrint("📍 Location capture failed: $e");
      }

      // 🟢 Fix: Use exchange rate for any currency other than LKR
      if (settings.selectedCurrency != AppCurrency.LKR) {
        amountLkr = transaction.amount * settings.exchangeRate;
      }

      final normalizedTransaction = transaction.copyWith(
          amount: amountLkr,
          latitude: lat,
          longitude: lng,
          locationName: locName
      );

      await _financeRepository.addTransaction(normalizedTransaction);

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

  Future<void> changeFilter(TransactionFilter filter, String uid) async {
    _selectedFilter = filter;
    String filterType = filter.name;
    try {
      _filteredTransactions =
          await _financeRepository.getFilteredTransactions(filterType, uid);
      notifyListeners();
    } catch (e) {
      debugPrint("❌ something wrong with getting filtered transactions $e");
    }
  }

  Future<void> exportTransactionsToCsv() async {
    _isLoading = true;
    notifyListeners();

    try {
      final csvData = CsvHelper.generateFianceSummary(
          totalBalance: _totalBalance ?? 0.0,
          totalIncome: _income,
          totalExpense: _expense,
          transactions: transactions,
          categories: categories);



      String? outputFile = await  FilePicker.saveFile(
        dialogTitle: 'Save your Financial Report',
        fileName: 'finance_report_${DateTime.now().millisecondsSinceEpoch}.csv',
        type: FileType.custom,
        bytes: utf8.encode(csvData),
        allowedExtensions: ['csv'],
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsString(csvData);

        // 🟢 Success Feedback
        debugPrint("✅ File saved to: $outputFile");
      }
      // await file.writeAsString(csvData);

    } catch (e) {
      debugPrint("❌ CSV Export Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTransaction(
      TransactionEntity transaction, SettingProvider settings) async {
    _isLoading = true;
    notifyListeners();

    try {
      double amountLkr = transaction.amount;

      // 🟢 Fix: Use exchange rate for any currency other than LKR
      if (settings.selectedCurrency != AppCurrency.LKR) {
        amountLkr = transaction.amount * settings.exchangeRate;
      }

      final normalizedTransaction = transaction.copyWith(amount: amountLkr);
      await _financeRepository.updateTransaction(normalizedTransaction);
      await loadFinanceData(transaction.userUid);

    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ Error updating transaction: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteTransaction(String tid, String uid) async {

    transactions.removeWhere((tx) => tx.tid == tid);
    _filteredTransactions.removeWhere((tx) => tx.tid == tid);

    _isLoading = true;
    notifyListeners();

    try {
      await _financeRepository.removeTransaction(tid);
      await loadFinanceData(uid);
    } catch (e) {
      _errMessage = e.toString();
      debugPrint("❌ Error deleting transaction: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // 🟢 Fix: Use exchange rate for any currency other than LKR
  double getDisplayTotalBalance(SettingProvider settings) {
    if (_totalBalance == null) return 0.0;
    return settings.selectedCurrency != AppCurrency.LKR
        ? _totalBalance! / settings.exchangeRate
        : _totalBalance!;
  }

  double getDisplayIncome(SettingProvider settings) {
    return settings.selectedCurrency != AppCurrency.LKR
        ? _income / settings.exchangeRate
        : _income;
  }

  double getDisplayExpense(SettingProvider settings) {
    return settings.selectedCurrency != AppCurrency.LKR
        ? _expense / settings.exchangeRate
        : _expense;
  }
}

enum TransactionFilter { all, income, expense }
