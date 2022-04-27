import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as p;

abstract class DBHelper {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasePath = await getDatabasesPath();

      String path = p.join(databasePath, 'flutter_sqflite.db');
      _db = await openDatabase(path,
          version: _version, onCreate: onCreate, onUpgrade: onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    String sqlQuery = 'CREATE TABLE `subject` (' +
        'id_subject INTEGER PRIMARY KEY AUTOINCREMENT,' +
        'subject STRING' +
        'description STRING';
    await db.execute(sqlQuery);
  }

  static void onUpgrade(Database db, int oldversion, int version) async {
    if (oldversion > version) {}
  }

  static Future<List<Map<String, dynamic>>> query(String table) {
    return _db!.query(table);
  }
}
