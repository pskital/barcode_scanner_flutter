import 'package:flutter/material.dart';

class Keys {
  static const scanBarcodeKey = Key('scan_barcode_key');
  static const saveBarcodeKey = Key('save_barcode_key');
  static const listBarcodeKey = Key('list_barcode_key');
  static GlobalKey<NavigatorState> navKey = GlobalKey();
}
