// import 'package:geolocator/geolocator.dart';
//
// class LocationService {
//   // This function returns a 'Position' object which contains Latitude and Longitude
//   Future<Position> fetchCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // 1. Check if the device's GPS is actually turned on
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled in your browser.');
//     }
//
//     // 2. Check if the user has given us permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // Ask for permission!
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('You denied the location permission.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception('Location permissions are permanently denied.');
//     }
//
//     // 3. If all checks pass, grab the exact GPS coordinates!
//     return await Geolocator.getCurrentPosition();
//   }
// }