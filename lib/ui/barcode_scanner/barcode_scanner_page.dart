import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(barcodeScannerPageTitle)),
      body: SafeArea(
        child: Stack(
          children: [
            QRBarScannerCamera(
              qrCodeCallback: (code) {
                if (code != null) {
                  context.read<BarcodeBloc>().qrCodeCallback(context, code);
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
    );
  }
}
