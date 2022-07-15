import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_modal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerBloc extends BlocBase<BarcodeModalState> {
  BarcodeScannerBloc() : super(ModalEnabledState());

  void qrCodeCallback(BuildContext context, String code) {
    if (state is ModalDisabledState) {
      return;
    }

    emit(ModalShowState(context, code));
    emit(ModalDisabledState());
  }

  void enableModal() {
    emit(ModalEnabledState());
  }
}
