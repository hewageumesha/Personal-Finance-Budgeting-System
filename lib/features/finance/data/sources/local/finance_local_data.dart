import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/model/category_model.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/model/transaction_model.dart';

import '../../../../../core/db/db_helper.dart';

class FinanceLocalData {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> addLocalCategory(CategoryModel categoryModel) async {
    try {
      final db = await _databaseHelper.db;
      await db?.insert('categories', categoryModel.toMap());
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<void> removeLocalCategory(String cid) async {
    try {
      final db = await _databaseHelper.db;
      await db?.delete('categories', where: 'cid = ?', whereArgs: [cid]);
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<List<CategoryModel>> getLocalCategories(String uid) async {
    try {
      final db = await _databaseHelper.db;

      // there are two user_id because one for specific user other for all when they sign up (common categories)
      final List<Map<String, dynamic>>? maps = await db?.query(
        'categories',
        where: 'user_uid = ? OR user_uid = ?',
        whereArgs: [uid, 'system'],
      );

      List<CategoryModel> list = List.generate(maps!.length, (i) {
        return CategoryModel.fromMap(maps[i]);
      });

      return list;
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<void> addLocalTransaction(TransactionModel transactionModel) async {
    try {
      final db = await _databaseHelper.db;
      await db?.insert('transactions', transactionModel.toMap());
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<void> removeLocalTransaction(String tid) async {
    try {
      final db = await _databaseHelper.db;
      await db?.delete('transactions', where: 'tid = ?', whereArgs: [tid]);
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<List<TransactionModel>> getLocalTransactions(String uid) async {
    try {
      final db = await _databaseHelper.db;

      final List<Map<String, dynamic>>? maps = await db?.query(
        'transactions',
        where: 'user_uid = ?',
        whereArgs: [uid],
        orderBy: 'date DESC',
      );

      List<TransactionModel> list = List.generate(maps!.length, (i) {
        return TransactionModel.fromMap(maps[i]);
      });

      return list;
    } catch (e) {
      // DataSource knows it's a DB problem
      throw Exception('Database issue $e');
    }
  }

  Future<double> getLocalTotalBalance(String uid) async {
    try {
      final db = await _databaseHelper.db;
      final List<Map<String, dynamic>>? result = await db?.rawQuery('''
        SELECT SUM(amount) as total from transactions where user_uid = ?
      ''', [uid]);

      if (result != null &&
          result.first['total'] != null &&
          result.isNotEmpty) {
        debugPrint("✅ Total balance fetched: $result");
        return result.first['total'].toDouble();
      }

      return 0.0;
    } catch (e) {
      throw Exception('Failed to retrieve total balance $e');
    }
  }
}
