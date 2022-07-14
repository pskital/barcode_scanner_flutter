import 'package:barcode_scanner_flutter/database/barcode_entity.dart';

class BarcodeModel {
  final BarcodeEntity barcodeEntity;

  final String createdAt;

  BarcodeModel(this.barcodeEntity, this.createdAt);
}
