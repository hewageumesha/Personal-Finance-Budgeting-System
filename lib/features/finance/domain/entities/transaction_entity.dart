class TransactionEntity {
  final String tid;
  final String title;
  final double amount;
  final DateTime date;
  final String? categoryName;
  final String description;
  final String cid;
  final String userUid;

  TransactionEntity({
    required this.tid, required this.amount, required this.date, required this.description, required this.cid, required this.userUid, required this.title,this.categoryName
  });

  TransactionEntity copyWith({
    String? tid,
    String? title,
    double? amount,
    DateTime? date,
    String? categoryName,
    String? description,
    String? cid,
    String? userUid,
  }) {
    return TransactionEntity(
      tid: tid ?? this.tid,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      cid: cid ?? this.cid,
      userUid: userUid ?? this.userUid,
    );
  }

}