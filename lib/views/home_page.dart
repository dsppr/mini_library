import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/book_viewmodel.dart';
import '../views/add_book_page.dart';
import '../views/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookViewModel>(context, listen: false).loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mini Library')),
      body: bookViewModel.books.isEmpty
          ? const Center(child: Text('No books available.'))
          : ListView.builder(
              itemCount: bookViewModel.books.length,
              itemBuilder: (context, index) {
                final book = bookViewModel.books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
