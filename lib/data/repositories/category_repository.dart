import '../local/database_helper.dart';
import '../models/category_model.dart';

class CategoryRepository {
  // Get the singleton instance of DatabaseHelper to interact with the database
  final dbHelper = DatabaseHelper.instance;

  // Fetch all categories from the 'categories' table
  Future<List<CategoryModel>> getAllCategories() async {
    // Access the database instance
    final db = await dbHelper.database;

    // Query the 'categories' table and get the result as a List of Maps
    final List<Map<String, dynamic>> maps = await db.query('categories');

    // Convert the List of Maps into a List of CategoryModel objects
    return List.generate(maps.length, (i) {
      return CategoryModel.fromMap(maps[i]);
    });
  }

  // Insert a new category into the 'categories' table
  Future<int> insertCategory(CategoryModel category) async {
    // Access the database instance
    final db = await dbHelper.database;

    // Convert the CategoryModel object to a Map and insert it
    return await db.insert('categories', category.toMap());
  }
}