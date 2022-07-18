import 'package:barcode_scanner_flutter/bloc/barcode/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_bloc.dart';
import 'package:barcode_scanner_flutter/utils/keys.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerModal extends StatelessWidget
    implements ModalDialogInterface {
  final String code;

  const BarcodeScannerModal(this.code, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onCancelModalDialog(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: BarcodeModalContentWidget(this, code),
        ),
      ),
    );
  }

  @override
  void onCancelModalDialog(BuildContext context) {
    context.read<BarcodeScannerBloc>().enableModalDialog();
    Navigator.pop(context);
  }

  @override
  void onSaveBarcode(BuildContext context, String code) {
    context.read<BarcodeBloc>().add(InsertBarcodeEvent(code));
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

class BarcodeModalContentWidget extends StatelessWidget {
  final ModalDialogInterface modalDialogInterface;
  final String code;

  const BarcodeModalContentWidget(this.modalDialogInterface, this.code,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 270,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(barcodeScanModalTitle,
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Text(code),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    key: Keys.saveBarcodeKey,
                    child: const Text(barcodeScanModalSaveText),
                    onPressed: () =>
                        modalDialogInterface.onSaveBarcode(context, code)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                    child: const Text(barcodeScanModalCancelText),
                    onPressed: () =>
                        modalDialogInterface.onCancelModalDialog(context)),
              )
            ],
          )
        ],
      ),
    );
  }
}

abstract class ModalDialogInterface {
  void onSaveBarcode(BuildContext context, String code);

  void onCancelModalDialog(BuildContext context);
}
