import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/buku_viewmodel.dart';
import '../models/buku.dart';
import '../views/detail_page.dart';
import '../views/add_edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bukuViewModel = Provider.of<BukuViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Library'),
        actions: [
          // Button untuk refresh daftar buku
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              bukuViewModel.fetchBooks();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: bukuViewModel.fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load books.'));
          } else {
            final books = bukuViewModel.books;
            if (books.isEmpty) {
              return const Center(
                child: Text('No books available.'),
              );
            }
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: book.coverImage != null
                        ? NetworkImage(book.coverImage!)
                        : null,
                    child:
                        book.coverImage == null ? const Icon(Icons.book) : null,
                  ),
                  title: Text(book.title),
                  subtitle: Text('by ${book.author}'),
                  onTap: () {
                    // Navigasi ke halaman detail buku
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigasi ke halaman tambah/edit buku
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditPage()),
          );
        },
      ),
    );
  }
}
