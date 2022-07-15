import 'package:barcode_scanner_flutter/bloc/barcode/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_event.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeListItem extends StatelessWidget {
  final BarcodeModel barcodeModel;
  final Animation<double> animation;

  const BarcodeListItem({
    Key? key,
    required this.barcodeModel,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          Padding(
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
                  onPressed: () {
                    context
                        .read<BarcodeBloc>()
                        .add(DeleteBarcodeEvent(barcodeModel));
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Icon(Icons.delete),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xffd2d2d2),
          )
        ],
      ),
    );
  }
}
