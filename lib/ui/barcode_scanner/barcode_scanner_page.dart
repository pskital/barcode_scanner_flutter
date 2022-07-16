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
    context.read<BarcodeScannerBloc>().enableModalDialog();
    return BlocListener<BarcodeScannerBloc, ScannerModalState>(
      listener: _onScannerModalStateChange,
      child: Scaffold(
        appBar: AppBar(title: const Text(barcodeScannerPageTitle)),
        body: SafeArea(
          child: Stack(
            children: [
              QRBarScannerCamera(
                  qrCodeCallback: (code) => _qrCodeCallback(context, code)),
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

  void _qrCodeCallback(BuildContext context, String? code) {
    if (code == null) {
      return;
    }
    context.read<BarcodeScannerBloc>().qrCodeCallback(code);
  }

  void _onScannerModalStateChange(
      BuildContext context, ScannerModalState state) {
    if (state is ScannerModalShowState) {
      showDialog(
          context: context,
          builder: (context) {
            return BarcodeScannerModal(state.code);
          });
    }
  }
}
