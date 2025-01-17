import 'package:flutter/material.dart';
import '../models/book.dart';
import '../database/db_helper.dart';

class BookViewModel extends ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> loadBooks() async {
    _books = await DBHelper.getBooks();
    notifyListeners();
  }
}
