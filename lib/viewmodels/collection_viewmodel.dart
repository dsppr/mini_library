import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../database/db_helper.dart';

class CollectionViewModel extends ChangeNotifier {
  List<Collection> _collections = [];

  List<Collection> get collections => _collections;

  Future<void> loadCollections() async {
    _collections = await DBHelper.getCollections();
    notifyListeners();
  }

  Future<void> addCollection(Collection collection) async {
    await DBHelper.insertCollection(collection);
    await loadCollections();
  }
}
