import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/buku.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter untuk mendapatkan instance database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('library.db');
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Membuat tabel di database
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        category TEXT NOT NULL,
        status TEXT NOT NULL,
        content TEXT NOT NULL,
        coverImage TEXT
      )
    ''');
  }

  // Fungsi untuk menambahkan data buku
  Future<int> insertBook(Buku buku) async {
    final db = await instance.database;
    return await db.insert('books', buku.toMap());
  }

  // Fungsi untuk mengambil semua data buku
  Future<List<Buku>> fetchBooks() async {
    final db = await instance.database;
    final result = await db.query('books');
    return result.map((map) => Buku.fromMap(map)).toList();
  }

  // Fungsi untuk memperbarui data buku
  Future<int> updateBook(Buku buku) async {
    final db = await instance.database;
    return await db.update(
      'books',
      buku.toMap(),
      where: 'id = ?',
      whereArgs: [buku.id],
    );
  }

  // Fungsi untuk menghapus data buku
  Future<int> deleteBook(int id) async {
    final db = await instance.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Menutup koneksi database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
