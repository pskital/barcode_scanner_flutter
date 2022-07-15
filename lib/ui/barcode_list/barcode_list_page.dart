import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_view.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class BarcodeListPage extends StatelessWidget {
  const BarcodeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(barcodeListPageTitle)),
      body: SafeArea(
        child: Column(
          children: <Widget>[BarcodeListView(), const ScanBarcodeButton()],
        ),
        // child: BarcodeListView(),
      ),
    );
  }
}

class ScanBarcodeButton extends StatelessWidget {
  const ScanBarcodeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
          );
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            padding: const EdgeInsets.all(16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        child: Stack(
          alignment: Alignment.center,
          children: const <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                barcodeScanButtonText,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.document_scanner,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
