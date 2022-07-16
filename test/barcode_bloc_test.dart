import 'package:barcode_scanner_flutter/bloc/barcode/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_event.dart';
import 'package:barcode_scanner_flutter/bloc/barcode/barcode_state.dart';
import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_modal_state.dart';
import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/models/barcode_model.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

class MockBarcodeRepository extends Mock implements BarcodeRepository {}

void main() {
  late MockBarcodeRepository barcodeRepository;

  setUp(() {
    barcodeRepository = MockBarcodeRepository();
  });

  group('barcode bloc tests', () {
    blocTest<BarcodeBloc, BarcodeState>(
      'test loading barcodes',
      setUp: () {
        when(() => barcodeRepository.getBarcodes())
            .thenAnswer((_) => Future.value([]));
      },
      wait: const Duration(milliseconds: 500),
      build: () => BarcodeBloc(barcodeRepository),
      act: (bloc) => bloc.add(GetBarcodesEvent()),
      expect: () => <BarcodeState>[BarcodeLoadingState(), BarcodeLoadedState()],
    );

    var expectedId = 1;
    var expectedTime = DateTime.now();
    var expectedBarcode = 'test_barcode';
    var expectedBarcodeEntity =
        BarcodeEntity(expectedBarcode, expectedTime, expectedId);
    var expectedBarcodeModel = BarcodeModel(
        expectedBarcodeEntity, DateFormat('yyyy-MM-dd').format(DateTime.now()));

    blocTest<BarcodeBloc, BarcodeState>('test insert barcode',
        setUp: () {
          when(
            () => barcodeRepository.insertBarcode(expectedBarcode),
          ).thenAnswer((_) => Future.value(
              BarcodeEntity(expectedBarcode, expectedTime, expectedId)));
        },
        wait: const Duration(milliseconds: 500),
        build: () => BarcodeBloc(barcodeRepository),
        act: (bloc) {
          bloc.add(InsertBarcodeEvent(expectedBarcode));
        },
        expect: () => <BarcodeState>[
              BarcodeLoadingState(),
              BarcodeInsertedState(expectedBarcodeModel)
            ]);

    blocTest<BarcodeBloc, BarcodeState>('test delete barcode',
        setUp: () {
          when(
            () => barcodeRepository.deleteBarcode(expectedBarcodeEntity),
          ).thenAnswer((_) => Future.value());
        },
        wait: const Duration(milliseconds: 500),
        build: () => BarcodeBloc(barcodeRepository),
        act: (bloc) {
          bloc.add(DeleteBarcodeEvent(expectedBarcodeModel));
        },
        expect: () => <BarcodeState>[
              BarcodeLoadingState(),
              BarcodeDeletedState(expectedBarcodeModel)
            ]);
  });

  group('scanner bloc tests', () {
    var expectedBarcode = 'test_barcode';

    blocTest<BarcodeScannerBloc, ScannerModalState>(
      'test scanner modal disabled state',
      wait: const Duration(milliseconds: 500),
      build: () => BarcodeScannerBloc(),
      act: (bloc) => bloc.qrCodeCallback(expectedBarcode),
      expect: () => <ScannerModalState>[
        ScannerModalShowState(expectedBarcode),
        ScannerModalDisabledState()
      ],
    );
  });
}
