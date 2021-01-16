import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvide.db.newScan(newScan);
    newScan.id = id;
    if(this.selectedType === newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }
  }
}
