import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   true,
        //   ScanMode.DEFAULT,
        // );
        final barcodeScanRes = 'http://www.luisdelgallego.co';
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.newScan(barcodeScanRes);
        scanListProvider.newScan('geo:143253.231421,234.2134');
      },
    );
  }
}
