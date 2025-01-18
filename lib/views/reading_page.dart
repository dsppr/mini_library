import 'package:flutter/material.dart';
import '../models/book.dart';

class ReadingPage extends StatelessWidget {
  final Book book;

  const ReadingPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading: ${book.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Here is the content of the book "${book.title}".\n\n'
            'Author: ${book.author}\n\n'
            '(Simulasi konten buku dapat dimuat di sini)',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
