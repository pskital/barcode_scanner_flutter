import 'package:barcode_scanner_flutter/bloc/barcode/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_state.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeListView extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  BarcodeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcodeBloc = context.read<BarcodeBloc>()..add(GetBarcodesEvent());
    return BlocListener<BarcodeBloc, BarcodeState>(
      listener: (context, state) => _updateBarcodeList(barcodeBloc, state),
      child: Expanded(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                  overscroll: false, physics: const ClampingScrollPhysics()),
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                initialItemCount: 0,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return BarcodeListItem(
                    deleteBarcodeKey: Key('delete_barcode_$index'),
                    barcodeModel: barcodeBloc.barcodeList[index],
                    animation: animation,
                  );
                },
              ),
            ),
            Center(
              child: BlocBuilder<BarcodeBloc, BarcodeState>(
                  builder: (context, state) {
                return Center(
                    child: Visibility(
                  visible: state is BarcodeLoadingState,
                  child: const CircularProgressIndicator(),
                ));
              }),
            )
          ],
        ),
      ),
    );
  }

  void _updateBarcodeList(BarcodeBloc barcodeBloc, BarcodeState state) {
    switch (state.runtimeType) {
      case BarcodeInsertedState:
        _onBarcodeInserted(barcodeBloc, state);
        break;
      case BarcodeDeletedState:
        _onBarcodeDeleted(barcodeBloc, state);
        break;
      case BarcodeLoadedState:
        _onBarcodesLoaded(barcodeBloc);
        break;
    }
  }

  void _onBarcodeInserted(BarcodeBloc barcodeBloc, BarcodeState state) {
    BarcodeModel barcodeModel = (state as BarcodeInsertedState).barcodeModel;
    var length = barcodeBloc.barcodeList.length;

    _listKey.currentState?.insertItem(length);
    barcodeBloc.barcodeList.add(barcodeModel);

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 90,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear);
    });
  }

  void _onBarcodeDeleted(BarcodeBloc barcodeBloc, BarcodeState state) {
    var removedItem = (state as BarcodeDeletedState).barcodeModel;
    var index = barcodeBloc.barcodeList.indexOf(removedItem);

    if (index < 0) {
      return;
    }

    _listKey.currentState?.removeItem(index, (context, animation) {
      return BarcodeListItem(
        deleteBarcodeKey: Key('delete_barcode_$index'),
        barcodeModel: removedItem,
        animation: animation,
      );
    });
    barcodeBloc.barcodeList.remove(removedItem);
  }

  void _onBarcodesLoaded(BarcodeBloc barcodeBloc) {
    for (int i = 0; i < barcodeBloc.barcodeList.length; i++) {
      _listKey.currentState?.insertItem(i);
    }
  }
}
