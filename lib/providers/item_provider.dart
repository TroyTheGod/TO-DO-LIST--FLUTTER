import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_1/database/items.dart';
import 'package:test_1/database/database_control.dart';

class Item extends ChangeNotifier {
  List<Items> _itemList = [];

  List<Items> get itemList => _itemList;

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

  Map tomap() {
    Map entireMap = {};
    for (int i = 0; i < _itemList.length; i++) {
      entireMap.addAll({
        _itemList[i].toMap()['id']: {
          'itemName': _itemList[i].toMap()['itemName'],
          'statusInInt': _itemList[i].toMap()['statusInInt']
        }
      });
    }
    return (entireMap);
  }

  void fromMap(DataSnapshot snapshot) {
    List<Items> tempList = [];
    if (snapshot.exists) {
      for (int i = 0; i < snapshot.children.length; i++) {
        Map temp = snapshot.children.elementAt(i).value as Map;
        Items tempItem = Items(
          i,
          temp['itemName'],
          temp['statusInInt'] == 0 ? false : true,
        );
        tempList.add(tempItem);
      }
      _itemList = tempList;
      notifyListeners();
    }
  }
}
