import 'package:flutter/material.dart';

class CategoryIconHelper {
  static IconData getIcon(String? categoryName) {
    switch (categoryName?.toLowerCase().trim()) {
      case 'food':
      case 'dining':
      case 'restaurant':
        return Icons.lunch_dining_rounded;
      case 'groceries':
        return Icons.local_grocery_store_rounded;
      case 'salary':
      case 'income':
      case 'bonus':
        return Icons.payments_rounded;
      case 'transport':
      case 'travel':
      case 'fuel':
        return Icons.directions_car_rounded;
      case 'shopping':
      case 'clothing':
        return Icons.shopping_bag_rounded;
      case 'health':
      case 'medical':
      case 'pharmacy':
        return Icons.medical_information_rounded;
      case 'education':
      case 'books':
        return Icons.menu_book_rounded;
      case 'entertainment':
      case 'movies':
      case 'games':
        return Icons.sports_esports_rounded;
      case 'rent':
      case 'housing':
        return Icons.home_rounded;
      case 'utilities':
      case 'bills':
      case 'electricity':
      case 'water':
        return Icons.receipt_long_rounded;
      case 'savings':
      case 'investment':
        return Icons.savings_rounded;
      case 'insurance':
        return Icons.verified_user_rounded;
      case 'gift':
      case 'charity':
        return Icons.redeem_rounded;
      case 'other':
      case 'miscellaneous':
        return Icons.more_horiz_rounded;
      default:
        return Icons.grid_view_rounded; // More modern fallback
    }
  }

  static Color getIconColor(String? categoryName) {
    switch (categoryName?.toLowerCase().trim()) {
      case 'food':
      case 'dining':
      case 'restaurant':
        return const Color(0xFFFF9800); // Orange
      case 'groceries':
        return const Color(0xFF4CAF50); // Green
      case 'salary':
      case 'income':
      case 'bonus':
        return const Color(0xFF00C853); // Bright Green
      case 'transport':
      case 'travel':
      case 'fuel':
        return const Color(0xFF2196F3); // Blue
      case 'shopping':
      case 'clothing':
        return const Color(0xFFE91E63); // Pink
      case 'health':
      case 'medical':
      case 'pharmacy':
        return const Color(0xFFF44336); // Red
      case 'education':
      case 'books':
        return const Color(0xFF9C27B0); // Purple
      case 'entertainment':
      case 'movies':
      case 'games':
        return const Color(0xFF673AB7); // Deep Purple
      case 'rent':
      case 'housing':
        return const Color(0xFF795548); // Brown
      case 'utilities':
      case 'bills':
      case 'electricity':
      case 'water':
        return const Color(0xFF607D8B); // Blue Grey
      case 'savings':
      case 'investment':
        return const Color(0xFF009688); // Teal
      case 'insurance':
        return const Color(0xFF3F51B5); // Indigo
      case 'gift':
      case 'charity':
        return const Color(0xFFFF5252); // Soft Red
      case 'other':
      case 'miscellaneous':
        return const Color(0xFF757575); // Dark Grey
      default:
        return const Color(0xFF9E9E9E); // Grey
    }
  }
}
