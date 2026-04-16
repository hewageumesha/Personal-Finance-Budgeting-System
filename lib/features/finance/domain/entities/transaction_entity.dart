class TransactionEntity {
  final String tid;
  final double amount;
  final DateTime date;
  final String description;
  final String cid;
  final String userUid;

  TransactionEntity({
    required this.tid, required this.amount, required this.date, required this.description, required this.cid, required this.userUid
  });
}