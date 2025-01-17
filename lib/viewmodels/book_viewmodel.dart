import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/book.dart';

class BookViewModel extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  final _dbHelper = DatabaseHelper.instance;

  Future<void> loadBooks() async {
    try {
      final data = await _dbHelper.queryAll('books');
      _books = data.map((item) => Book.fromMap(item)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading books: $e");
    }
  }

  Future<void> addBook(Book book) async {
    try {
      await _dbHelper.insert('books', book.toMap());
      await loadBooks();
    } catch (e) {
      debugPrint("Error adding book: $e");
    }
  }

  Future<void> updateBook(Book book) async {
    try {
      await _dbHelper.update('books', book.toMap(), 'id = ?', [book.id]);
      await loadBooks();
    } catch (e) {
      debugPrint("Error updating book: $e");
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await _dbHelper.delete('books', 'id = ?', [id]);
      await loadBooks();
    } catch (e) {
      debugPrint("Error deleting book: $e");
    }
  }
}
