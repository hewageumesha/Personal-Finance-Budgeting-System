import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/currency/currency_service.dart';

enum AppCurrency { LKR, USD }

class SettingProvider extends ChangeNotifier {
  final CurrencyService _currencyService = CurrencyService();

  AppCurrency _selectedCurrency = AppCurrency.LKR;
  double _exchangeRate = 300.0;
  bool _isLoading = false;

  AppCurrency get selectedCurrency => _selectedCurrency;

  double get exchangeRate => _exchangeRate;

  bool get isLoading => _isLoading;

  String get currencySymbol =>
      _selectedCurrency == AppCurrency.LKR ? 'Rs.' : '\$';

  void toggleCurrency() async {
    if (_selectedCurrency == AppCurrency.LKR) {
      _selectedCurrency = AppCurrency.USD;
      await fetchLastestRate();
    } else {
      _selectedCurrency = AppCurrency.LKR;
    }
    notifyListeners();
  }

  Future<void> fetchLastestRate() async{
    _isLoading = true;
    notifyListeners();
    try{
      _exchangeRate = await _currencyService.fetchUsdToLkrRate();
      print(_exchangeRate);
    }catch(e){
      debugPrint("Rate fetch failed $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}
