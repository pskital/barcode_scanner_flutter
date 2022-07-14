import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/utils/constants.dart';
import 'package:floor/floor.dart';

@dao
abstract class BarcodeDao {
  @Query('SELECT * FROM $barcodeTableName')
  Stream<List<BarcodeEntity>> getBarcodes();

  @insert
  Future<void> insertBarcode(BarcodeEntity barcodeEntity);

  @delete
  Future<void> deleteBarcode(BarcodeEntity barcodeEntity);
}
