import 'package:barcode_scanner_flutter/models/barcode_model.dart';

abstract class BarcodeEvent {}

class InsertBarcodeEvent extends BarcodeEvent {
  String code;

  InsertBarcodeEvent(this.code);
}

class DeleteBarcodeEvent extends BarcodeEvent {
  BarcodeModel barcodeModel;

  DeleteBarcodeEvent(this.barcodeModel);
}

class GetBarcodesEvent extends BarcodeEvent {}
