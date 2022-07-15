import 'dart:async';

import 'package:barcode_scanner_flutter/bloc/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_state.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  final BarcodeRepository barcodeRepository;

  final _dateFormat = DateFormat('yyyy-MM-dd');

  bool isBarcodeModalDisplayed = false;
  List<BarcodeModel> barcodeList = [];

  BarcodeBloc(this.barcodeRepository) : super(BarcodeInitialState()) {
    on<InsertBarcodeEvent>(_onInsertBarcode);
    on<DeleteBarcodeEvent>(_onDeleteBarcode);
    on<GetBarcodesEvent>(_onGetBarcodes);
  }

  Future<void> _onGetBarcodes(event, emit) async {
    emit(BarcodeLoadingState());

    await Future.delayed(const Duration(milliseconds: 400));
    var list = await barcodeRepository.getBarcodes();
    barcodeList = list
        .map((barcodeEntity) => BarcodeModel(
            barcodeEntity, _dateFormat.format(barcodeEntity.createdAt)))
        .toList();
    emit(BarcodeLoadedState());
  }

  Future<void> _onDeleteBarcode(event, emit) async {
    emit(BarcodeLoadingState());

    await Future.delayed(const Duration(milliseconds: 400));
    var barcodeModel = event.barcodeModel;
    await barcodeRepository.deleteBarcode(barcodeModel.barcodeEntity);
    emit(BarcodeDeletedState(barcodeModel));
  }

  Future<void> _onInsertBarcode(event, emit) async {
    emit(BarcodeLoadingState());

    await Future.delayed(const Duration(milliseconds: 400));
    var barcodeEntity = await barcodeRepository.insertBarcode(event.code);
    var barcodeModel = BarcodeModel(
        barcodeEntity, _dateFormat.format(barcodeEntity.createdAt));
    emit(BarcodeInsertedState(barcodeModel));
  }

  void qrCodeCallback(BuildContext context, String code) {
    if (isBarcodeModalDisplayed) {
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return BarcodeScannerModal(
              code: code,
              dismissCallback: () {
                isBarcodeModalDisplayed = false;
              });
        });

    isBarcodeModalDisplayed = true;
  }
}
