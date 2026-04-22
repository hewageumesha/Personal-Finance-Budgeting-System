Data Model (DTO/Mapper)

Used for JSON or SQL conversion.
May import json_annotation or SQL helpers.

eg : - TransactionModel , 


```dart
class TransactionModel extends Transaction {
  TransactionModel({required super.id, required super.amount, required super.date, required super.categoryId});

  // Specifically for SQLite or API conversion
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      categoryId: map['categoryId'],
    );
  }
}
```