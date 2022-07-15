import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_state.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeListView extends StatelessWidget {
  const BarcodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> listKey = GlobalKey();
    final barcodeBloc = context.read<BarcodeBloc>();
    return BlocListener<BarcodeBloc, BarcodeState>(
      listener: (context, state) {
        if (state is BarcodeDeletedState) {
          BarcodeModel removedItem = state.barcodeModel;
          var index = barcodeBloc.barcodeList.indexOf(removedItem);

          if (index < 0) {
            return;
          }

          listKey.currentState?.removeItem(index, (context, animation) {
            return BarcodeListItem(
                barcodeModel: removedItem, animation: animation);
          });
          barcodeBloc.barcodeList.remove(removedItem);
        }

        if (state is BarcodeInsertedState) {
          BarcodeModel barcodeModel = state.barcodeModel;
          listKey.currentState?.insertItem(barcodeBloc.barcodeList.length);
          barcodeBloc.barcodeList.add(barcodeModel);
        }

        if (state is BarcodeLoadedState) {
          for (int i = 0; i < barcodeBloc.barcodeList.length; i++) {
            listKey.currentState?.insertItem(i);
          }
        }
      },
      child: AnimatedList(
        key: listKey,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        initialItemCount: barcodeBloc.barcodeList.length,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return BarcodeListItem(
            barcodeModel: barcodeBloc.barcodeList[index],
            animation: animation,
          );
        },
      ),
    );
  }
}
