import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/buku.dart';
import '../viewmodels/buku_viewmodel.dart';

class ReadingPage extends StatelessWidget {
  final Buku book;

  const ReadingPage({super.key, required this.book});

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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  book.content, // Menampilkan konten buku
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (book.status != 'Dipinjam') {
                  final updatedBook = Buku(
                    id: book.id,
                    title: book.title,
                    author: book.author,
                    category: book.category,
                    status: 'Dipinjam', // Ubah status menjadi dipinjam
                    content: book.content,
                  );
                  bukuViewModel.updateBook(updatedBook);
                  Navigator.pop(
                      context); // Kembali ke halaman detail setelah pinjam
                }
              },
              child: const Text('Pinjam Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
