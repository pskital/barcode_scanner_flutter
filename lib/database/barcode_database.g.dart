// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorBarcodeDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BarcodeDatabaseBuilder databaseBuilder(String name) =>
      _$BarcodeDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BarcodeDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$BarcodeDatabaseBuilder(null);
}

class _$BarcodeDatabaseBuilder {
  _$BarcodeDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$BarcodeDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$BarcodeDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<BarcodeDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$BarcodeDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$BarcodeDatabase extends BarcodeDatabase {
  _$BarcodeDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BarcodeDao? _barcodeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `barcode_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `code` TEXT NOT NULL, `created_at` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BarcodeDao get barcodeDao {
    return _barcodeDaoInstance ??= _$BarcodeDao(database, changeListener);
  }
}

class _$BarcodeDao extends BarcodeDao {
  _$BarcodeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _barcodeEntityInsertionAdapter = InsertionAdapter(
            database,
            'barcode_table',
            (BarcodeEntity item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'created_at': _dateTimeConverter.encode(item.createdAt)
                },
            changeListener),
        _barcodeEntityDeletionAdapter = DeletionAdapter(
            database,
            'barcode_table',
            ['id'],
            (BarcodeEntity item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'created_at': _dateTimeConverter.encode(item.createdAt)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BarcodeEntity> _barcodeEntityInsertionAdapter;

  final DeletionAdapter<BarcodeEntity> _barcodeEntityDeletionAdapter;

  @override
  Stream<List<BarcodeEntity>> getBarcodes() {
    return _queryAdapter.queryListStream('SELECT * FROM barcode_table',
        mapper: (Map<String, Object?> row) => BarcodeEntity(
            row['code'] as String,
            _dateTimeConverter.decode(row['created_at'] as int),
            row['id'] as int?),
        queryableName: 'barcode_table',
        isView: false);
  }

  @override
  Future<void> insertBarcode(BarcodeEntity barcodeEntity) async {
    await _barcodeEntityInsertionAdapter.insert(
        barcodeEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBarcode(BarcodeEntity barcodeEntity) async {
    await _barcodeEntityDeletionAdapter.delete(barcodeEntity);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
