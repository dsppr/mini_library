import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// void printDatabasePath() async {
//   String path = join(await getDatabasesPath(),
//       'mini_library.db'); // Ganti 'my_database.db' dengan nama database Anda
//   print('Database path: $path');
// }

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mini_library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const bookTable = '''
    CREATE TABLE books (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author TEXT NOT NULL,
      category TEXT,
      status TEXT NOT NULL,
      description TEXT
    )
    ''';
    await db.execute(bookTable);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> values,
      String whereClause, List whereArgs) async {
    final db = await instance.database;
    return await db.update(table, values,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String whereClause, List whereArgs) async {
    final db = await instance.database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }
}
