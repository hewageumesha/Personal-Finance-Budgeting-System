class TransactionModel {
  final int? id;
  final int userId;
  final int categoryId;
  final double amount;
  final DateTime date;
  final String description;

  TransactionModel({
    this.id,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
  });

  // Convert the object into a Map before sending it to the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  // Convert a Map received from the database back into an Object
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      userId: map['user_id'],
      categoryId: map['category_id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }
}