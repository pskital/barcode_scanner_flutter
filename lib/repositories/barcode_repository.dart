import 'package:barcode_scanner_flutter/database/barcode_database.dart';
import 'package:barcode_scanner_flutter/database/barcode_entity.dart';

class BarcodeRepository {
  final BarcodeDatabase barcodeDatabase;

  BarcodeRepository(this.barcodeDatabase);

  Future<BarcodeEntity> insertBarcode(String code) async {
    var barcodeEntity = BarcodeEntity(code, DateTime.now());
    var rowId = await barcodeDatabase.barcodeDao.insertBarcode(barcodeEntity);
    barcodeEntity.id = rowId;
    return barcodeEntity;
  }

  Future<void> deleteBarcode(BarcodeEntity barcodeEntity) async {
    await barcodeDatabase.barcodeDao.deleteBarcode(barcodeEntity.id!);
  }

  Future<List<BarcodeEntity>> getBarcodes() {
    return barcodeDatabase.barcodeDao.getBarcodes();
  }
}
