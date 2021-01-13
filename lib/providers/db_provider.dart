import 'package:sqflite/sqflite.dart';

class DBProvide {
  static Database _database;
  static final DBProvide db = DBProvide._();

  DBProvide._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {}
}
