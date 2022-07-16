import 'package:barcode_scanner_flutter/bloc/barcode/barcode_bloc.dart';
import 'package:barcode_scanner_flutter/bloc/scanner/barcode_scanner_bloc.dart';
import 'package:barcode_scanner_flutter/database/barcode_database_provider.dart';
import 'package:barcode_scanner_flutter/repositories/barcode_repository.dart';
import 'package:barcode_scanner_flutter/utils/app_router.dart';
import 'package:barcode_scanner_flutter/utils/keys.dart';
import 'package:barcode_scanner_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var barcodeDatabase = await BarcodeDatabaseProvider.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => BarcodeBloc(BarcodeRepository(barcodeDatabase)),
    ),
    BlocProvider(
      create: (_) => BarcodeScannerBloc(),
    ),
  ], child: const BarcodeScannerApp()));
}

class BarcodeScannerApp extends StatelessWidget {
  const BarcodeScannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Keys.navKey,
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: appTitle,
        initialRoute: AppRouter.barcodeListPage);
  }
}
