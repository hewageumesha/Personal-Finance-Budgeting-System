import 'dart:math';

import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel(
      {required super.tid,
      required super.amount,
      required super.date,
      required super.description,
      required super.cid,
      required super.userUid,
      required super.title,
      super.categoryName});

  // fromEntity
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
        tid: entity.tid,
        amount: entity.amount,
        date: entity.date,
        description: entity.description,
        cid: entity.cid,
        userUid: entity.userUid,
        title: entity.title,
        categoryName: entity.categoryName);
  }

  // fetch from db
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        tid: map['tid'],
        amount: map['amount'],
        date: DateTime.parse(map['date']),
        description: map['description'],
        cid: map['category_id'],
        userUid: map['user_uid'],
        title: map['title'],
        categoryName: map['categoryName']);
  }

  // convert category to map , for database operations
  Map<String, dynamic> toMap() {
    return {
      'tid': tid,
      'amount': amount,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'category_id': cid,
      'user_uid': userUid
    };
  }
}
