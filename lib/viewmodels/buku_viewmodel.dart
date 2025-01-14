import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/buku.dart';

class BukuViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<Buku> _books = [];
  List<Buku> get books => _books;

  // Fetch all books from the database
  Future<void> fetchBooks() async {
    _books = await _dbHelper.fetchBooks();
    notifyListeners();
  }

  // Add a new book
  Future<void> addBook(Buku buku) async {
    await _dbHelper.insertBook(buku);
    await fetchBooks(); // Refresh the list
  }

  // Update an existing book
  Future<void> updateBook(Buku buku) async {
    await _dbHelper.updateBook(buku);
    await fetchBooks(); // Refresh the list
  }

  // Delete a book
  Future<void> deleteBook(int id) async {
    await _dbHelper.deleteBook(id);
    await fetchBooks(); // Refresh the list
  }
}
