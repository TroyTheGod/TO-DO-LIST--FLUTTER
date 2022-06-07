import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:test_1/providers/item_provider.dart';
import 'package:flutter/services.dart';

class FirebaseHelper {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/');

  void store(Map entiremap) async {
    ref.set(entiremap);
  }

  Future<DataSnapshot> restore() async {
    DataSnapshot snapshot = await ref.get();
    return snapshot;
  }
}
