import 'package:equatable/equatable.dart';

abstract class ScannerModalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScannerModalEnabledState extends ScannerModalState {}

class ScannerModalShowState extends ScannerModalState {
  final String code;

  ScannerModalShowState(this.code);

  @override
  List<Object> get props => [code];
}

class ScannerModalDisabledState extends ScannerModalState {}
