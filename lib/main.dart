import 'package:barcode_scanner_flutter/database/barcode_database_provider.dart';
import 'package:barcode_scanner_flutter/utils/pages.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BarcodeDatabaseProvider().init();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      getPages: Pages.pageList,
      initialRoute: Pages.barcodeListPage));
}
