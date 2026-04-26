class CurrencyMock {
  static const double _usdToLkrRate = 300.0;

  Future<double> fetchUsdToLkrRate() async {
    try{
      await Future.delayed(const Duration(milliseconds: 500));
      return _usdToLkrRate;
    }catch(e){
      throw Exception("Currency Service Error: $e");
    }
  }

  double convertUsdToLkr(double usdAmount){
    return usdAmount * _usdToLkrRate;
  }

  double convertLkrToUsd(double lkrAmount){
    if(_usdToLkrRate == 0) return 0.0;
    return lkrAmount/_usdToLkrRate;
  }

}