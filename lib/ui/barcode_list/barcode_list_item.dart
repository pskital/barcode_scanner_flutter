import 'package:barcode_scanner_flutter/controllers/barcode_list_controller.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeListItem extends GetView<BarcodeListController> {
  final BarcodeModel barcodeModel;

  const BarcodeListItem({
    Key? key,
    required this.barcodeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(barcodeModel.barcodeEntity.code),
          ),
          Text(barcodeModel.createdAt),
          ElevatedButton(
            onPressed: () async {
              await controller.deleteBarcode(barcodeModel.barcodeEntity);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
