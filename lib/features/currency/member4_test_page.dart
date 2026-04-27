import 'package:flutter/material.dart';
import 'currency_service.dart'; // Import the engine we just built

class Member4TestPage extends StatefulWidget {
  const Member4TestPage({super.key});

  @override
  State<Member4TestPage> createState() => _Member4TestPageState();
}

class _Member4TestPageState extends State<Member4TestPage> {
  // These variables hold the state of our screen
  String _displayResult = "Press the button to get the rate.";
  bool _isLoading = false; // To satisfy the "Loading Indicators" requirement

  // The function that runs when the button is pressed
  Future<void> _handleApiCall() async {
    setState(() {
      _isLoading = true; // Turn on the loading spinner
      _displayResult = "Connecting to server...";
    });

    try {
      // Call your engine
      CurrencyService service = CurrencyService();
      double rate = await service.fetchUsdToLkrRate();

      setState(() {
        _displayResult = "Success! 1 USD = $rate LKR";
      });
    } catch (error) {
      // If there is an error (like no internet), show it on screen
      setState(() {
        _displayResult = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false; // Turn off the loading spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member 4: API Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The Text that changes based on the API result
            Text(
              _displayResult,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // The Button (Shows a spinner if loading, or a button if not)
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _handleApiCall,
              child: const Text('Fetch USD to LKR Rate'),
            ),
          ],
        ),
      ),
    );
  }
}