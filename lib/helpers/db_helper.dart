import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

import '../providers/transaction.dart';

class DBHelper {
  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'courier.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE courier(id TEXT PRIMARY KEY, orders TEXT, km TEXT, hours TEXT, consume TEXT, price TEXT, date TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.dataBase();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Transaction tx) async {
    final db = await DBHelper.dataBase();
    db.rawUpdate(
      'UPDATE $table SET orders = ?, km = ?, hours = ?, consume = ?, price = ?, date = ? WHERE id = ?',
      [
        '${tx.orders}',
        '${tx.km}',
        '${tx.hours}',
        '${tx.consume}',
        '${tx.price}',
        '${tx.dateTime}',
        '${tx.id}'
      ],
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DBHelper.dataBase();
    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.dataBase();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
    // db.rawDelete('DELETE FROM $table WHERE id = ${id}');
  }
}
