import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/book_viewmodel.dart';
import '../widgets/book_item.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookViewModel>(
      builder: (context, bookVM, child) {
        return ListView.builder(
          itemCount: bookVM.books.length,
          itemBuilder: (context, index) {
            return BookItem(book: bookVM.books[index]);
          },
        );
      },
    );
  }
}
