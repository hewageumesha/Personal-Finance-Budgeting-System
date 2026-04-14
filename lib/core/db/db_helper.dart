import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;

  // singleton pattern
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'finflow.db');
    // callback func , passing a function
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        uid TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        username TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> verifyTables() async {
    final dbClient = await db;
    // Query the internal SQLite master table to see what exists
    var tables = await dbClient!.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='users'"
    );

    if (tables.isNotEmpty) {
      print("✅ SUCCESS: Table 'users' exists!");
    } else {
      print("❌ ERROR: Table 'users' NOT found in the database.");
    }
  }

  Future<void> seedMockUser() async {
    final dbClient = await db;

    // Hardcoded test data
    // CRITICAL: The 'uid' must match a user you've already created in the Firebase Console
    await dbClient?.insert(
      'users',
      {
        'uid': 'YB7EcWKY3dMjBmEeqYFN5g9R9bI2',
        'email': 'm@example.com',
        'username': 'TestDev2026',
        'createdAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Overwrites if already exists
    );

    print("Mock user seeded successfully!");
  }

}
