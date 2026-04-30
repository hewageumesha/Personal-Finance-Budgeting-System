class TransactionEntity {
  final String tid;
  final String title;
  final double amount;
  final DateTime date;
  final String? categoryName;
  final String description;
  final String cid;
  final String userUid;
  final double? latitude;
  final double? longitude;
  final String? locationName;

  TransactionEntity(
      {required this.tid,
      required this.amount,
      required this.date,
      required this.description,
      required this.cid,
      required this.userUid,
      required this.title,
      this.categoryName,
      this.latitude,
      this.longitude,
      this.locationName});

  TransactionEntity copyWith({
    String? tid,
    String? title,
    double? amount,
    DateTime? date,
    String? categoryName,
    String? description,
    String? cid,
    String? userUid,
    double? latitude,
    double? longitude,
    String? locationName,
  }) {
    return TransactionEntity(
      tid: tid ?? this.tid,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      cid: cid ?? this.cid,
      userUid: userUid ?? this.userUid,
    );
  }
}
