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


  Future<void> updateLocalTransaction(TransactionModel transaction) async {
    final db = await _databaseHelper.db;
    await db?.update('transactions', transaction.toMap(),where: 'tid = ?' ,whereArgs:[transaction.tid]);
  }

  Future<List<TransactionModel>> getLocalTransactions(String uid) async {
    try {
      final db = await _databaseHelper.db;

      // old Query One
      // final List<Map<String, dynamic>>? maps = await db?.query(
      //   'transactions',
      //   where: 'user_uid = ?',
      //   whereArgs: [uid],
      //   orderBy: 'date DESC',
      // );

      final List<Map<String, dynamic>>? maps = await db?.rawQuery('''
        SELECT t.*, c.cname as categoryName 
        FROM transactions t
        INNER JOIN categories c on t.category_id = c.cid
        WHERE t.user_uid = ?
        ORDER BY t.date DESC
      ''', [uid]);

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

  Future<double> getLocalExpenseTotal(String uid) async {
    try {
      final db = await _databaseHelper.db;

      String sql = '''
        SELECT SUM(amount) as expense from transactions where user_uid = ? and amount < 0
      ''';
      final List<Map<String, dynamic>>? result = await db?.rawQuery(sql, [uid]);

      if (result != null &&
          result.isNotEmpty &&
          result.first['expense'] != null) {
        return (result.first['expense'].toDouble()).abs();
      }

      return 0.0;
    } catch (e) {
      throw Exception('failed to get total expenses $e');
    }
  }

  Future<double> getLocalIncomeTotal(String uid) async {
    try {
      final db = await _databaseHelper.db;

      String sql = '''
        SELECT SUM(amount) as income from transactions where user_uid = ? and amount > 0
      ''';
      final List<Map<String, dynamic>>? result = await db?.rawQuery(sql, [uid]);

      if (result != null &&
          result.isNotEmpty &&
          result.first['income'] != null) {
        return result.first['income'].toDouble();
      }

      return 0.0;
    } catch (e) {
      throw Exception('failed to get total income $e');
    }
  }

  // get filtered transactions data
  Future<List<TransactionModel>> getFilteredTransactions(String uid,String filterType) async {
    try{
      final db = await _databaseHelper.db;

      String condition = "";
      if(filterType == "income"){
        condition = "AND t.amount > 0";
      }else if(filterType == "expense"){
        condition = "AND t.amount < 0";
      }

      String sql = '''
        SELECT t.*, c.cname as categoryName 
        FROM transactions t
        INNER JOIN categories c ON t.category_id = c.cid
        WHERE t.user_uid = ? $condition
      ''';

      final List<Map<String,dynamic>>? maps = await db?.rawQuery(sql,[uid]);

      return maps!.map((m) => TransactionModel.fromMap(m)).toList();

    }catch(e){
      throw Exception('database issue $e ❌');
    }
  }



}
