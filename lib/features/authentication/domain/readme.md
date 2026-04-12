this is Domain model (Entity)

Used by the UI and Logic. (Pure dart classess)

eg : User , Transaction etc ...


```dart
class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final String categoryId;

  Transaction({required this.id, required this.amount, required this.date, required this.categoryId});
}
```