import 'package:flutter/material.dart';

class CategoryIconHelper {
  static IconData getIcon(String? categoryName) {
    switch (categoryName?.toLowerCase()) {
      case 'food':
      case 'dining':
        return Icons.restaurant;
      case 'salary':
      case 'income':
        return Icons.account_balance_wallet;
      case 'transport':
      case 'travel':
        return Icons.directions_bus;
      case 'shopping':
        return Icons.shopping_cart;
      case 'health':
        return Icons.medical_services;
      case 'education':
        return Icons.school;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.category; // Fallback icon
    }
  }

  static Color getIconColor(String? categoryName) {
    switch (categoryName?.toLowerCase()) {
      case 'food': return Colors.orange;
      case 'salary': return Colors.lightGreenAccent;
      case 'transport': return Colors.blue;
      case 'shopping': return Colors.amberAccent;
      case 'health': return Colors.red;
      default: return Colors.grey;
    }
  }

}