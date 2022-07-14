import 'package:barcode_scanner_flutter/controllers/barcode_list_controller.dart';
import 'package:barcode_scanner_flutter/controllers/barcode_scanner_controller.dart';
import 'package:get/get.dart';

class BarcodeListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BarcodeListController());
  }
}

class BarcodeScannerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BarcodeScannerController());
  }
}
