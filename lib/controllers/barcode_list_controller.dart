import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BarcodeListController extends GetxController {
  final _barcodeRepository = BarcodeRepository();
  final _dateFormat = DateFormat('yyyy-MM-dd');

  Stream<List<BarcodeModel>>? _barcodesStream;

  @override
  void onInit() {
    _barcodesStream = _barcodeRepository.getBarcodes().map((barcodeList) =>
        barcodeList
            .map((barcodeEntity) => BarcodeModel(
                barcodeEntity, _dateFormat.format(barcodeEntity.createdAt)))
            .toList());
    super.onInit();
  }

  Stream<List<BarcodeModel>>? getBarcodesStream() {
    return _barcodesStream;
  }

  Future<void> deleteBarcode(BarcodeEntity barcodeEntity) async {
    await _barcodeRepository.deleteBarcode(barcodeEntity);
  }
}
