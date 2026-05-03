import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<double> fetchRateToLkr(String baseCurrency) async {
    try {
      final url = Uri.parse('https://open.er-api.com/v6/latest/$baseCurrency');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final lkrRate = decodedData['rates']['LKR'];
        return lkrRate.toDouble();
      } else {
        throw Exception('Server rejected the request.');
      }
    } catch (error) {
      throw Exception('Failed to connect. Please check your internet.');
    }
  }

  // Keeping this for backward compatibility if needed, but fetchRateToLkr is more generic
  Future<double> fetchUsdToLkrRate() async {
    return fetchRateToLkr('USD');
  }
}