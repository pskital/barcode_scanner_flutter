import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_page.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String barcodeListPage = '/';
  static const String barcodeScannerPage = '/scanner';

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case barcodeListPage:
        return MaterialPageRoute(builder: (context) => const BarcodeListPage());
      case barcodeScannerPage:
        return MaterialPageRoute(
          builder: (context) => const BarcodeScannerPage(),
        );
    }
    return null;
  }
}
