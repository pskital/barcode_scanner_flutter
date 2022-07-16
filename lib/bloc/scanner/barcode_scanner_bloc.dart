import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_modal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerBloc extends BlocBase<ScannerModalState> {
  BarcodeScannerBloc() : super(ScannerModalEnabledState());

  void qrCodeCallback(String code) {
    if (state is ScannerModalDisabledState) {
      return;
    }

    emit(ScannerModalShowState(code));
    emit(ScannerModalDisabledState());
  }

  void enableModalDialog() {
    emit(ScannerModalEnabledState());
  }
}
