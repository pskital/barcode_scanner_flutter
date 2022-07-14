import 'dart:async';

import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarcodeBloc extends BlocBase<List<BarcodeModel>> {
  StreamSubscription<List<BarcodeModel>>? _streamSubscription;

  final _barcodeRepository = BarcodeRepository();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  var _isDialogDisplayed = false;

  BarcodeBloc() : super([]) {
    _streamSubscription = _barcodeRepository
        .getBarcodes()
        .map((barcodeList) => barcodeList
            .map((barcodeEntity) => BarcodeModel(
                barcodeEntity, _dateFormat.format(barcodeEntity.createdAt)))
            .toList())
        .listen((event) {
      emit(event);
    });
  }

  void deleteBarcode(BarcodeEntity barcodeEntity) {
    _barcodeRepository.deleteBarcode(barcodeEntity);
  }

  void insertBarcode(String code) {
    _barcodeRepository.insertBarcode(code);
  }

  void qrCodeCallback(BuildContext context, String code) {
    if (_isDialogDisplayed) {
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return BarcodeScannerModal(
            code: code,
            dismissCallback: () {
              _isDialogDisplayed = false;
            }
          );
        });

    _isDialogDisplayed = true;
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
