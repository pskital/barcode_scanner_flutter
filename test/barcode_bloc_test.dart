import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_state.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBarcodeRepository extends Mock implements BarcodeRepository {}

void main() {
  late MockBarcodeRepository barcodeRepository;

  setUp(() {
    barcodeRepository = MockBarcodeRepository();
  });

  blocTest<BarcodeBloc, BarcodeState>(
    'test loading barcodes',
    setUp: () {
      when(() => barcodeRepository.getBarcodes())
          .thenAnswer((_) => Future.value([]));
    },
    build: () => BarcodeBloc(barcodeRepository),
    act: (bloc) => bloc.add(GetBarcodesEvent()),
    expect: () => [BarcodeLoadedState()],
  );
}
