class CategoryModel {
  final int? id;
  final String name;
  final String type; // Income or Expense

  CategoryModel({this.id, required this.name, required this.type});

  // Convert the object into a Map for the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type
    };
  }

  // Convert a Map from the database back into an Object
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
    );
  }
}