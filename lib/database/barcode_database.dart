import 'dart:async';

import 'package:barcode_scanner_flutter/database/barcode_dao.dart';
import 'package:barcode_scanner_flutter/database/barcode_entity.dart';
import 'package:barcode_scanner_flutter/database/converters/date_time_converter.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'barcode_database.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [BarcodeEntity])
abstract class BarcodeDatabase extends FloorDatabase {
  BarcodeDao get barcodeDao;
}
