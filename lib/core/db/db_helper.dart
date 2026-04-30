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
    return await openDatabase(path, version: 2, onCreate: _createDb, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE transactions ADD COLUMN location_name TEXT');
    }
  }

  Future<void> _createDb(Database db, int version) async {
    try {
      // users table
      await db.execute('''
      CREATE TABLE users(
        uid TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        username TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

      // category table
      await db.execute('''
        CREATE TABLE categories(
          cid TEXT PRIMARY KEY,
          cname TEXT NOT NULL,
          cType TEXT NOT NULL, 
          user_uid TEXT NOT NULL,
          FOREIGN KEY (user_uid) REFERENCES users (uid) ON DELETE CASCADE
        )
    ''');

      // transaction table
      await db.execute('''
      CREATE TABLE transactions(
        tid TEXT PRIMARY KEY,
        amount REAL not null,
        title text not null,
        description text,
        date text not null,
        
        latitude real,
        longitude real,
        location_name text,
        
        category_id TEXT NOT NULL, 
        user_uid TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (cid) ON DELETE CASCADE,
        FOREIGN KEY (user_uid) REFERENCES users (uid) ON DELETE CASCADE
      )
  ''');
    } catch (e) {
      print(e);
    }
  }
}
