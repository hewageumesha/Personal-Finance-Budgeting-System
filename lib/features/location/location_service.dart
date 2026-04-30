import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }

      if (permission == LocationPermission.deniedForever) return null;

      // 1. Try to get last known position first (instant)
      Position? lastPosition = await Geolocator.getLastKnownPosition();
      if (lastPosition != null) return lastPosition;

      // 2. If no last known, try current with a short timeout and low accuracy
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 3),
      );
    } catch (e) {
      debugPrint("📍 Location Error: $e");
      return null;
    }
  }

  Future<String?> getLocationName(double lat, double lng) async {
    try {
      // Use a cache or singleton if possible in the future, but for now just a timeout
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng)
          .timeout(const Duration(seconds: 2));

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return place.locality ?? place.subLocality ?? place.subAdministrativeArea ?? "Unknown Area";
      }
    } catch (e) {
      debugPrint("Geocoding failed: $e");
    }
    return null;
  }
}
