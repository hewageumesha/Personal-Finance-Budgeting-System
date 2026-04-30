import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/currency/currency_service.dart';

enum AppCurrency { LKR, USD, EUR }

class SettingProvider extends ChangeNotifier {
  final CurrencyService _currencyService = CurrencyService();

  AppCurrency _selectedCurrency = AppCurrency.LKR;
  double _exchangeRate = 1.0; // 1 LKR = 1 LKR
  bool _isLoading = false;

  AppCurrency get selectedCurrency => _selectedCurrency;

  double get exchangeRate => _exchangeRate;

  bool get isLoading => _isLoading;

  String get currencySymbol {
    switch (_selectedCurrency) {
      case AppCurrency.LKR:
        return 'Rs.';
      case AppCurrency.USD:
        return '\$';
      case AppCurrency.EUR:
        return '€';
    }
  }

  // Cycles through LKR -> USD -> EUR -> LKR
  void toggleCurrency() async {
    if (_selectedCurrency == AppCurrency.LKR) {
      _selectedCurrency = AppCurrency.USD;
    } else if (_selectedCurrency == AppCurrency.USD) {
      _selectedCurrency = AppCurrency.EUR;
    } else {
      _selectedCurrency = AppCurrency.LKR;
    }

    if (_selectedCurrency == AppCurrency.LKR) {
      _exchangeRate = 1.0;
      notifyListeners();
    } else {
      await fetchLastestRate();
    }
  }

  // Allow setting a specific currency
  void setCurrency(AppCurrency currency) async {
    if (_selectedCurrency == currency) return;

    _selectedCurrency = currency;
    if (_selectedCurrency == AppCurrency.LKR) {
      _exchangeRate = 1.0;
      notifyListeners();
    } else {
      await fetchLastestRate();
    }
  }

  Future<void> fetchLastestRate() async {
    _isLoading = true;
    notifyListeners();
    try {
      _exchangeRate = await _currencyService.fetchRateToLkr(_selectedCurrency.name);
      print("New rate for ${_selectedCurrency.name}: $_exchangeRate");
    } catch (e) {
      debugPrint("Rate fetch failed $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
