import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/buku_viewmodel.dart';
import '../models/buku.dart';
import 'add_edit_page.dart';
import 'reading_page.dart'; // Import halaman membaca buku

class DetailPage extends StatelessWidget {
  final Buku book;

  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final bukuViewModel = Provider.of<BukuViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Author: ${book.author}'),
            const SizedBox(height: 8),
            Text('Category: ${book.category}'),
            const SizedBox(height: 8),
            Text('Status: ${book.status}'),
            const SizedBox(height: 16),
            Text(
              book.content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit',
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPage(book: book),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'delete',
            backgroundColor: Colors.red,
            onPressed: () {
              bukuViewModel.deleteBook(book.id!);
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'read',
            child: const Icon(Icons.book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingPage(
                      book: book), // Menavigasi ke halaman membaca buku
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
