import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required super.cid,
      required super.cname,
      required super.cType,
      required super.userUid});

  // fromEntity
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
        cid: entity.cid,
        cname: entity.cname,
        cType: entity.cType,
        userUid: entity.userUid);
  }

  // fetch from db
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        cid: map['cid'],
        cname: map['cname'],
        cType: CategoryType.values.firstWhere((e)=> e.name == map['cType']), // String to enum
        userUid: map['user_uid']);
  }

  // convert category to map , for database operations

  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'cname': cname,
      'cType': cType.name, // enum -> string for sqlite
      'user_uid': userUid
    };
  }
}
