import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './items.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE items(id INTEGER PRIMARY KEY, itemName TEXT, statusInInt INTEGER)');
  }

  Future<void> insert(Items items) async {
    final db = await instance.database;
    await db.insert(
      'items',
      items.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(int index) async {
    final db = await instance.database;
    await db.delete('items', where: 'id = ?', whereArgs: [index]);
  }

  Future<List<Items>> getAllItems() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (index) {
      return Items(
        maps[index]['id'],
        maps[index]['itemName'],
        maps[index]['statusInInt'] == 1 ? true : false,
      );
    });
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
