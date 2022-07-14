import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeListView extends StatelessWidget {
  const BarcodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeBloc, List<BarcodeModel>>(
      builder: (context, barcodes) {
        return Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: barcodes.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
            color: Color(0xffd2d2d2),
          ),
          itemBuilder: (BuildContext context, int index) {
            return BarcodeListItem(
              barcodeModel: barcodes[index],
            );
          },
        ));
      },
    );
  }
}
