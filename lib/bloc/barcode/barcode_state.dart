import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:equatable/equatable.dart';

abstract class BarcodeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BarcodeInitialState extends BarcodeState {}

class BarcodeLoadingState extends BarcodeState {}

class BarcodeLoadedState extends BarcodeState {}

class BarcodeDeletedState extends BarcodeState {
  final BarcodeModel barcodeModel;

  BarcodeDeletedState(this.barcodeModel);

  @override
  List<Object?> get props => [
        barcodeModel.barcodeEntity.id,
        barcodeModel.barcodeEntity.code,
        barcodeModel.barcodeEntity.createdAt
      ];
}

class BarcodeInsertedState extends BarcodeState {
  final BarcodeModel barcodeModel;

  BarcodeInsertedState(this.barcodeModel);

  @override
  List<Object?> get props => [
        barcodeModel.barcodeEntity.id,
        barcodeModel.barcodeEntity.code,
        barcodeModel.barcodeEntity.createdAt
      ];
}
