import 'package:barcode_scanner_flutter/main.dart' as app;
import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_page.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_modal.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:barcode_scanner_flutter/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("insert barcode integration test", (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.scanButtonKey));
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(BarcodeScannerPage), findsOneWidget);

    NavigatorState navigator = Keys.navKey.currentState!;

    showDialog(
        context: navigator.context,
        builder: (c) => const BarcodeScannerModal('test_code'));

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.byKey(Keys.saveBarcodeButtonKey));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(BarcodeScannerModal), findsNothing);
    expect(find.byType(BarcodeListPage), findsOneWidget);
  });
}
