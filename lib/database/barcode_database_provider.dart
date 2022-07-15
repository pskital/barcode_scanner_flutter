import 'package:barcode_scanner_flutter/database/barcode_database.dart';
import 'package:barcode_scanner_flutter/utils/constants.dart';

class BarcodeDatabaseProvider {
  static Future<BarcodeDatabase> init() async {
    return await $FloorBarcodeDatabase
        .databaseBuilder(barcodeDatabaseName)
        .build();
  }
}
