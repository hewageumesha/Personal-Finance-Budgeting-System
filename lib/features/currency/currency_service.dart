import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  // The 'Future' keyword means this task takes time to finish (async).
  Future<double> fetchUsdToLkrRate() async {
    // We use a 'try-catch' block to satisfy your "Robust Error Handling" requirement.
    try {
      // 1. We call out to the free internet API
      final url = Uri.parse('https://open.er-api.com/v6/latest/USD');
      final response = await http.get(url);

      // 2. Check if the internet call was successful (Code 200 means OK)
      if (response.statusCode == 200) {
        // 3. Decode the JSON data the server sent us
        final decodedData = json.decode(response.body);

        // 4. Extract just the LKR (Sri Lankan Rupee) rate from the giant list
        final lkrRate = decodedData['rates']['LKR'];

        // Convert it to a double (decimal number) and return it
        return lkrRate.toDouble();
      } else {
        // If the server is broken, we throw an error
        throw Exception('Server rejected the request.');
      }
    } catch (error) {
      // If the user has no internet, it gets caught right here
      throw Exception('Failed to connect. Please check your internet.');
    }
  }
}