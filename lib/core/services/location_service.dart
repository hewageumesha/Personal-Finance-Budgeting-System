import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("📍 Location services are disabled.");
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint("📍 Location permissions are denied.");
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint("📍 Location permissions are permanently denied.");
        return null;
      }

      // 1. Try to get last known position first (instant)
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) {
        debugPrint("📍 Using last known location.");
        return lastPosition;
      }

      // 2. If no last known, try current with a more reasonable timeout for physical devices
      debugPrint("📍 Requesting fresh current position...");
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 10), // Increased for physical devices
      );
    } catch (e) {
      debugPrint("📍 Location Error: $e");
      return null;
    }
  }

  Future<String?> getLocationName(double lat, double lng) async {
    try {
      // Geocoding can be slow on physical devices depending on network
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng)
          .timeout(const Duration(seconds: 5)); // Increased timeout

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Construct a more descriptive name if possible
        return place.locality ?? 
               place.subLocality ?? 
               place.subAdministrativeArea ?? 
               place.name ?? 
               "Unknown Area";
      }
    } catch (e) {
      debugPrint("📍 Geocoding failed: $e");
    }
    return null;
  }
}
