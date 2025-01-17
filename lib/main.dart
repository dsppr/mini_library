import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/book_viewmodel.dart';
import 'viewmodels/collection_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MiniLibraryApp());
}

class MiniLibraryApp extends StatelessWidget {
  const MiniLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookViewModel()),
        ChangeNotifierProvider(create: (_) => CollectionViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Library',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
