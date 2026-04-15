class TransactionEntity {
  final int tid;
  final double amount;
  final DateTime date;
  final String description;
  final int cid;
  final int userUid;

  TransactionEntity({
    required this.tid, required this.amount, required this.date, required this.description, required this.cid, required this.userUid
  });
}