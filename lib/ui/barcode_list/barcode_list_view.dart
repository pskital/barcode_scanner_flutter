import 'package:barcode_scanner_flutter/controllers/barcode_list_controller.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeListView extends GetView<BarcodeListController> {
  const BarcodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<BarcodeModel>>(
        stream: controller.getBarcodesStream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return Container();
          final barcodes = snapshot.requireData;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: barcodes.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1,
              color: Color(0xffd2d2d2),
            ),
            itemBuilder: (BuildContext context, int index) {
              return BarcodeListItem(
                barcodeModel: barcodes[index],
              );
            },
          );
        },
      ),
    );
  }
}
