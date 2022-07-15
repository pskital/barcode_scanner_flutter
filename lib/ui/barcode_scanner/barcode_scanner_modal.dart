import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_event.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerModal extends StatelessWidget {
  final Function dismissCallback;

  final String code;

  const BarcodeScannerModal(
      {Key? key, required this.code, required this.dismissCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
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
                      child: const Text(barcodeScanModalSaveText),
                      onPressed: () {
                        _saveBarcode(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      child: const Text(barcodeScanModalCancelText),
                      onPressed: () {
                        Navigator.pop(context);
                        dismissCallback();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveBarcode(BuildContext context) {
    context.read<BarcodeBloc>().add(InsertBarcodeEvent(code));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
