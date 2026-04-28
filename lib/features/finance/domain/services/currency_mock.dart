// class CurrencyMock {
//   static const double _usdToLkrRate = 300.0;
//
//   Future<double> fetchUsdToLkrRate() async {
//     try{
//       await Future.delayed(const Duration(milliseconds: 500));
//       return _usdToLkrRate;
//     }catch(e){
//       throw Exception("Currency Service Error: $e");
//     }
//   }
//
//   double convertUsdToLkr(double usdAmount){
//     return usdAmount * _usdToLkrRate;
//   }
//
//   double convertLkrToUsd(double lkrAmount){
//     if(_usdToLkrRate == 0) return 0.0;
//     return lkrAmount/_usdToLkrRate;
//   }
//
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyMock {

  Future<double> fetchUsdToLkrRate() async {

    try {

      final url = Uri.parse('https://open.er-api.com/v6/latest/USD'); // lkr
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final lkrRate = decodedData['rates']['LKR'];
        print(lkrRate);
        return lkrRate.toDouble();
      } else {
        throw Exception('Server rejected the request.');
      }
    } catch (error) {
      throw Exception('Failed to connect. Please check your internet.');
    }
  }
}