import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Items(
        ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        Name TEXT NOT NULL,
        Catagory TEXT NOT NULL,
        Quantity TEXT NOT NULL,
        Measurment TEXT NOT NULL,
        LocalArea TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'store_management.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (add item)
  static createItem(String name, String catagory, String quantity,
      String measurment, String? localArea) async {
    final db = await SQLHelper.db();

    final data = {
      'Name': name,
      'Catagory': catagory,
      'Quantity': quantity,
      'Measurment': measurment,
      'localArea': localArea
    };
    int r = await db.insert('Items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return r;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();

    
    // db.query('Items').then((value) {
    // //   for (var element in value) {
    // //     // print(element);
    // //   }
    // // });
    return db.query('Items');
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('Items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('Items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(String id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Items", where: "ID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
