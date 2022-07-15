import 'package:barcode_scanner_flutter/bloc/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/barcode_state.dart';
import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

class MockBarcodeRepository extends Mock implements BarcodeRepository {}

var dateFormat = DateFormat('yyyy-MM-dd');

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
    wait: const Duration(milliseconds: 1000),
    build: () => BarcodeBloc(barcodeRepository),
    act: (bloc) => bloc.add(GetBarcodesEvent()),
    expect: () => <BarcodeState>[BarcodeLoadingState(), BarcodeLoadedState()],
  );

  group('barcode insert', () {
    var expectedId = 1;
    var expectedTime = DateTime.now();
    var expectedCode = 'test_barcode';

    var expectedModel = BarcodeModel(
        BarcodeEntity(expectedCode, expectedTime, expectedId),
        dateFormat.format(DateTime.now()));

    blocTest<BarcodeBloc, BarcodeState>('test barcode insert',
        setUp: () {
          when(
            () => barcodeRepository.insertBarcode(expectedCode),
          ).thenAnswer((code) => Future.value(
              BarcodeEntity(expectedCode, expectedTime, expectedId)));
        },
        wait: const Duration(milliseconds: 1000),
        build: () => BarcodeBloc(barcodeRepository),
        act: (bloc) {
          bloc.add(InsertBarcodeEvent(expectedCode));
        },
        expect: () => <BarcodeState>[
              BarcodeLoadingState(),
              BarcodeInsertedState(expectedModel)
            ]);
  });
}
