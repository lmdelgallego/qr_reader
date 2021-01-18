import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvide.db.newScan(newScan);
    newScan.id = id;
    if (this.selectedType == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvide.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByTy(String type) async {
    final scans = await DBProvide.db.getScansByType(type);
    this.selectedType = type;
    this.scans = [...scans];
    notifyListeners();
  }

  deleteById(int id) async {
    await DBProvide.db.deleteScan(id);
  }

  deleteAlls() async {
    await DBProvide.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }
}
