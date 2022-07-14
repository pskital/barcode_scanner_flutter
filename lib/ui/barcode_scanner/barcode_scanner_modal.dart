import 'package:barcode_scanner_flutter/controllers/barcode_scanner_controller.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeScannerModal extends GetView<BarcodeScannerController> {
  final Function dismissCallback;

  final String code;

  const BarcodeScannerModal(
      {Key? key, required this.code, required this.dismissCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
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
                        _saveBarcode(scaffoldMessengerState);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      child: const Text(barcodeScanModalCancelText),
                      onPressed: () {
                        Get.back();
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

  void _saveBarcode(ScaffoldMessengerState scaffoldMessengerState) async {
    await controller.insertBarcode(code);

    Get.back();
    dismissCallback();

    scaffoldMessengerState.hideCurrentSnackBar();
    scaffoldMessengerState.showSnackBar(
      const SnackBar(content: Text(barcodeScanModalConfirmationText)),
    );
  }
}
