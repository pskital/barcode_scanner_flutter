import 'package:barcode_scanner_flutter/ui/barcode_list/barcode_list_page.dart';
import 'package:barcode_scanner_flutter/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:barcode_scanner_flutter/utils/page_bindings.dart';
import 'package:get/get.dart';

class Pages {
  Pages._();

  static const String barcodeListPage = "/barcode_list_page";
  static const String barcodeScannerPage = "/barcode_scanner_page";

  static List<GetPage> get pageList => [
        GetPage(
            name: Pages.barcodeListPage,
            binding: BarcodeListBinding(),
            page: () {
              return const BarcodeListPage();
            }),
        GetPage(
            name: Pages.barcodeScannerPage,
            binding: BarcodeScannerBinding(),
            page: () {
              return const BarcodeScannerPage();
            }),
      ];
}
