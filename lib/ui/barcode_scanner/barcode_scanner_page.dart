import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_modal_state.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeScannerBloc, BarcodeModalState>(
      listener: _onModalDialogStateChange,
      child: Scaffold(
        appBar: AppBar(title: const Text(barcodeScannerPageTitle)),
        body: SafeArea(
          child: Stack(
            children: [
              QRBarScannerCamera(
                qrCodeCallback: (code) {
                  if (code != null) {
                    var bloc = context.read<BarcodeScannerBloc>();
                    bloc.qrCodeCallback(context, code);
                  }
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset('assets/images/qr_scanner_center.png',
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onModalDialogStateChange(BuildContext buildContext, BarcodeModalState state) {
    if (state is ModalShowState) {
      showDialog(
          context: buildContext,
          builder: (context) {
            return BlocProvider<BarcodeScannerBloc>.value(
                value: buildContext.read<BarcodeScannerBloc>(),
                child: BarcodeScannerModal(code: state.code));
          });
    }
  }
}
