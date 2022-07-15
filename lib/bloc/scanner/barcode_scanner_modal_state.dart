import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class BarcodeModalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ModalEnabledState extends BarcodeModalState {}

class ModalShowState extends BarcodeModalState {
  final BuildContext context;
  final String code;

  ModalShowState(this.context, this.code);

  @override
  List<Object> get props => [code];
}

class ModalDisabledState extends BarcodeModalState {}
