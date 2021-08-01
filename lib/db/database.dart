import 'package:consentify/model/agreement.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AgreementDatabase {
  static final AgreementDatabase instance = AgreementDatabase._init();

  static Database _database;

  AgreementDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('agreement.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final textType = 'TEXT NOT NULL';

    // // await db.execute('''
    // // CREATE TABLE $tableAgreement (
    // //   ${AgreementField.id} $idType,
    // //   ${AgreementField.consentAsker} $textType,
    // //   ${AgreementField.consentGiver} $textType,
    // //   ${AgreementField.consentAskerEmail} $textType,
    // //   ${AgreementField.consentGiverEmail} $textType,
    // //   ${AgreementField.agreementTime} $textType,)''');

    await db.execute('''CREATE TABLE agreements (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      consentAsker TEXT NOT NULL,
      consentGiver TEXT NOT NULL,
      consentAskerEmail TEXT NOT NULL,
      consentGiverEmail TEXT NOT NULL,
      agreementTime TEXT NOT NULL )''');
  }

  Future<Agreement> create(Agreement agreement) async {
    final db = await instance.database;

    final id = await db.insert(tableAgreement, agreement.toJson());
    return agreement.copy(id: id);
  }

  Future<Agreement> readAgreement(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAgreement,
      columns: AgreementField.values,
      where: '${AgreementField.id} = $id',
    );

    if (maps.isNotEmpty) {
      return Agreement.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Agreement>> readAllAgreement() async {
    final db = await instance.database;

    final orderBy = '${AgreementField.agreementTime} ASC';
    final result = await db.query(tableAgreement, orderBy: orderBy);

    return result.map((json) => Agreement.fromJson(json)).toList();
  }

  // Future<int> update

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAgreement,
      where: '${AgreementField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
