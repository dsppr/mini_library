import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/collection_viewmodel.dart';

class CollectionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Koleksi Buku")),
      body: Consumer<CollectionViewModel>(
        builder: (context, collectionViewModel, _) {
          return ListView.builder(
            itemCount: collectionViewModel.collections.length,
            itemBuilder: (context, index) {
              final collection = collectionViewModel.collections[index];
              return ListTile(
                title: Text(collection.name),
                onTap: () {
                  // Navigasi ke detail koleksi
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan koleksi baru
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
