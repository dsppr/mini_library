import 'package:flutter/material.dart';
import '../models/book.dart';

class CollectionItem extends StatelessWidget {
  final Book book;
  final VoidCallback onRemove;

  const CollectionItem({Key? key, required this.book, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(book.coverUrl,
            width: 50, height: 75, fit: BoxFit.cover),
        title: Text(book.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(book.author),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
