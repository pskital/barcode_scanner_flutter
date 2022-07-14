import 'package:barcode_scanner_flutter/database/barcode_database.dart';
import 'package:barcode_scanner_flutter/utils/constants.dart';

class BarcodeDatabaseProvider {
  static final BarcodeDatabaseProvider _barcodeDatabaseProvider =
      BarcodeDatabaseProvider._internal();

  late BarcodeDatabase barcodeDatabase;

  init() async {
    barcodeDatabase = await $FloorBarcodeDatabase
        .databaseBuilder(barcodeDatabaseName)
        .build();
  }

  factory BarcodeDatabaseProvider() {
    return _barcodeDatabaseProvider;
  }

  BarcodeDatabaseProvider._internal();
}
