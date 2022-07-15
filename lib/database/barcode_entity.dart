import 'package:barcode_scanner_flutter/utils/constants.dart';
import 'package:floor/floor.dart';

@Entity(tableName: barcodeTableName)
class BarcodeEntity {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;
  @ColumnInfo(name: 'code')
  final String code;
  @ColumnInfo(name: 'created_at')
  final DateTime createdAt;

  BarcodeEntity(this.code, this.createdAt, [this.id]);
}
