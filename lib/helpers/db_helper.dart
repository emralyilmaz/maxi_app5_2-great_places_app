import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    // oluşturacağımız veritabanımızı depolayabileceğimiz yol.
    final sqlDb = await sql.openDatabase(path.join(dbPath, "places.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
    }, version: 1);
    // veritabanını açmamıza sağlar. bizim belirttiğimiz yolda bir tane bulursa mevcut olanı açar ya da yeni bir tane yaratır.
    sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
