import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:get/get.dart';

class BarcodeScannerController extends GetxController {
  final _barcodeRepository = BarcodeRepository();

  var _isDialogDisplayed = false;

  Future<void> insertBarcode(String code) async {
    await _barcodeRepository.insertBarcode(code);
  }

  void qrCodeCallback(String code) {
    if (_isDialogDisplayed) {
      return;
    }

    Get.dialog(BarcodeScannerModal(
        code: code,
        dismissCallback: () {
          _isDialogDisplayed = false;
        }));

    _isDialogDisplayed = true;
  }
}
