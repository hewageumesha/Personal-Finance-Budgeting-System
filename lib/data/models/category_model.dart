enum CategoryType { income, expense }

class CategoryModel {
  final int? id;
  final String name;
  final CategoryType type; // Income or Expense as enum

  CategoryModel({this.id, required this.name, required this.type});

  // Convert the object into a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last, // store as string in DB
    };
  }

  // Convert a Map from SQLite back into a CategoryModel object
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    // Convert string from DB back to enum
    CategoryType categoryType =
    map['type'] == 'income' ? CategoryType.income : CategoryType.expense;

    return CategoryModel(
      id: map['id'],
      name: map['name'],
      type: categoryType,
    );
  }
}