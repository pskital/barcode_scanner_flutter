import 'package:barcode_scanner_flutter/database/barcode_database_provider.dart';
import 'package:barcode_scanner_flutter/database/barcode_entity.dart';

class BarcodeRepository {
  final _barcodeDatabase = BarcodeDatabaseProvider().barcodeDatabase;

  Future<void> insertBarcode(String code) async {
    await _barcodeDatabase.barcodeDao
        .insertBarcode(BarcodeEntity(code, DateTime.now()));
  }

  Future<void> deleteBarcode(BarcodeEntity barcodeEntity) async {
    await _barcodeDatabase.barcodeDao.deleteBarcode(barcodeEntity);
  }

  Stream<List<BarcodeEntity>> getBarcodes() {
    return _barcodeDatabase.barcodeDao.getBarcodes();
  }
}
