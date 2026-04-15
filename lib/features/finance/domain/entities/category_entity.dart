enum CategoryType {
  income,
  expense,
}

class CategoryEntity {
  final int cid;
  final String cname;
  final CategoryType cType;
  final String userUid;

  CategoryEntity(
      {required this.cid,
      required this.cname,
      required this.cType,
      required this.userUid});
}
