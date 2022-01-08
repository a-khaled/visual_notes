import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, description TEXT, dateTime TEXT, status TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getEntry(String table, String id) async {
    final db = await DBHelper.database();
    return db.query(table, where: 'id = "$id"');
  }

  static Future<void> update(String table, String id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update(table, data, where: 'id = "$id"');
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'id = "$id"');
  }
  
}
