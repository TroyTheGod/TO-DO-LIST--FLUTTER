import 'package:flutter/material.dart';
import 'package:test_1/database/items.dart';
import 'package:test_1/database/database_control.dart';

class Item extends ChangeNotifier {
  List<Items> _itemList = [];

  List get itemList => _itemList;

  void add(String item) {
    Items items = Items(
      _itemList.length,
      item,
    );
    _itemList.add(items);
    DatabaseHelper.instance.insert(items);
    notifyListeners();
  }

  void remove(int index) {
    _itemList.removeAt(index);
    DatabaseHelper.instance.remove(index);
    notifyListeners();
  }

  void initList(List<Items> itemList) {
    _itemList = itemList;
    notifyListeners();
  }
}
