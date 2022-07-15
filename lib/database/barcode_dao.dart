import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/utils/constants.dart';
import 'package:floor/floor.dart';

@dao
abstract class BarcodeDao {
  @Query('SELECT * FROM $barcodeTableName')
  Future<List<BarcodeEntity>> getBarcodes();

  @insert
  Future<int> insertBarcode(BarcodeEntity barcodeEntity);

  @Query('DELETE FROM $barcodeTableName WHERE id=:id')
  Future<void> deleteBarcode(int id);
}
