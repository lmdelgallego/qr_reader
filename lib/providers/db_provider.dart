import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvide {
  static Database _database;
  static final DBProvide db = DBProvide._();

  DBProvide._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde va la base de datos.

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScanDB.db');
    print(path);

    // Crear base de datos.

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE SCANS (
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        )
      ''');
    });
  }
}
