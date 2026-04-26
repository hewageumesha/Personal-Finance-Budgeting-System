import 'package:flutter/material.dart';

enum AppCurrency {LKR,USD}

class SettingProvider  extends ChangeNotifier{
  AppCurrency _selectedCurrency = AppCurrency.LKR;
  AppCurrency get selectedCurrency => _selectedCurrency;

  String get currencySymbol => _selectedCurrency == AppCurrency.LKR ? 'Rs.' : '\$';

  double get mockRate => 300.0;

  void toggleCurrency() {
    _selectedCurrency = _selectedCurrency == AppCurrency.LKR ? AppCurrency.USD : AppCurrency.LKR;
    notifyListeners();
}

}