import 'package:personal_finance_budgeting_system/features/finance/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel(
      {required super.tid,
      required super.amount,
      required super.date,
      required super.description,
      required super.cid,
      required super.userUid});

  // fetch from db
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        tid: map['tid'],
        amount: map['amount'],
        date: map['date'],
        description: map['description'],
        cid: map['category_id'],
        userUid: map['user_uid']);
  }

  // convert category to map , for database operations
  Map<String, dynamic> toMap() {
    return {
      'tid': tid,
      'amount': amount,
      'date': date,
      'description': description,
      'category_id': cid,
      'user_uid': userUid
    };
  }
}
