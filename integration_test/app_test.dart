import 'dart:math';

import 'package:barcode_scanner_flutter/main.dart' as app;
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_item.dart';
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_page.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:barcode_scanner_flutter/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("barcode scanner integration test", (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.byKey(Keys.scanBarcodeKey));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(BarcodeScannerPage), findsOneWidget);

    final String expectedBarcode = String.fromCharCodes(
        List.generate(5, (index) => Random().nextInt(33) + 89));

    final NavigatorState navigator = Keys.navKey.currentState!;
    showDialog(
        context: navigator.context,
        builder: (c) => BarcodeScannerModal(expectedBarcode));

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byKey(Keys.saveBarcodeKey));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(BarcodeScannerModal), findsNothing);
    expect(find.byType(BarcodeListPage), findsOneWidget);

    await tester.scrollUntilVisible(find.text(expectedBarcode), 100.0);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    final barcodeListItems =
        tester.widgetList<BarcodeListItem>(find.byType(BarcodeListItem));
    final lastBarcodeItem = barcodeListItems.last;
    expect(expectedBarcode, lastBarcodeItem.barcodeModel.barcodeEntity.code);

    await tester.tap(find.byKey(lastBarcodeItem.deleteBarcodeKey));
    await tester.pumpAndSettle();

    expect(find.text(expectedBarcode), findsNothing);

    await tester.pump(const Duration(seconds: 1));
  });
}
