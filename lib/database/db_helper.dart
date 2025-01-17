import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';
import '../models/collection.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'mini_library.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, author TEXT, coverImage TEXT)",
        );
        await db.execute(
          "CREATE TABLE collections(id INTEGER PRIMARY KEY, name TEXT, bookIds TEXT)",
        );
      },
    );
    return _database!;
  }

  static Future<List<Book>> getBooks() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) => Book.fromMap(maps[i]));
  }

  static Future<List<Collection>> getCollections() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('collections');
    return List.generate(maps.length, (i) => Collection.fromMap(maps[i]));
  }

  static Future<void> insertCollection(Collection collection) async {
    final db = await getDatabase();
    await db.insert('collections', collection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
