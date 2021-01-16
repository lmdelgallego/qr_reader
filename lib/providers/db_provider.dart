import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/models/scan_models.dart';
export 'package:qr_reader/models/scan_models.dart';

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

  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scan(id, type, value)
        VALUES($id, '$type', '$value')
    ''');
    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scan', newScan.toJson());
    // res es el ID del ultimo registro insertado.
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isEmpty
        ? res.map((e) => ScanModel.fromJson(res.first)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return res.isEmpty
        ? res.map((e) => ScanModel.fromJson(res.first)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel updateScan) async {
    final db = await database;
    final res = await db.update('Scans', updateScan.toJson(),
        where: 'id = ?', whereArgs: [updateScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    // final res = await db.delete('Scans');
    final res = await db.rawDelete('''
    DELETE FROM Scans
    ''');
    return res;
  }
}
