import 'package:flutter/material.dart';
import '../models/book.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(book.coverImage, width: 50, height: 50),
      title: Text(book.title),
      subtitle: Text(book.author),
    );
  }
}
