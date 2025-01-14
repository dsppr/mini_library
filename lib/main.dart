import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './viewmodels/buku_viewmodel.dart';
import './views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BukuViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Library',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(), // Ganti dengan halaman utama Anda
      ),
    );
  }
}
