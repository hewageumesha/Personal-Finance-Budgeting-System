// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'location_service.dart';
//
// class Member4LocationPage extends StatefulWidget {
//   const Member4LocationPage({super.key});
//
//   @override
//   State<Member4LocationPage> createState() => _Member4LocationPageState();
// }
//
// class _Member4LocationPageState extends State<Member4LocationPage> {
//   String _displayResult = "Press the button to find your location.";
//   bool _isLoading = false;
//
//   Future<void> _handleLocationCall() async {
//     setState(() {
//       _isLoading = true;
//       _displayResult = "Scanning satellites...";
//     });
//
//     try {
//       LocationService service = LocationService();
//       Position position = await service.fetchCurrentLocation();
//
//       setState(() {
//         _displayResult = "Success!\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}";
//       });
//     } catch (error) {
//       setState(() {
//         _displayResult = "Error: ${error.toString()}";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Member 4: Hardware Test')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.location_on, size: 60, color: Colors.blue),
//               const SizedBox(height: 20),
//               Text(
//                 _displayResult,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                 onPressed: _handleLocationCall,
//                 child: const Text('Fetch GPS Coordinates'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }