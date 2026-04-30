import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/currency/currency_service.dart';

enum AppCurrency { LKR, USD, EUR }

class SettingProvider extends ChangeNotifier {
  final CurrencyService _currencyService = CurrencyService();

  AppCurrency _selectedCurrency = AppCurrency.LKR;
  double _exchangeRate = 1.0;
  bool _isLoading = false;
  ThemeMode _themeMode = ThemeMode.light;

  AppCurrency get selectedCurrency => _selectedCurrency;
  double get exchangeRate => _exchangeRate;
  bool get isLoading => _isLoading;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

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

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

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

  Future<void> fetchLastestRate() async {
    _isLoading = true;
    notifyListeners();
    try {
      _exchangeRate = await _currencyService.fetchRateToLkr(_selectedCurrency.name);
    } catch (e) {
      debugPrint("Rate fetch failed $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
