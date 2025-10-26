import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'calculation_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  final String tableName = 'history';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('calculator_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT NOT NULL,
        result TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> create(Calculation calculation) async {
    final db = await instance.database;
    return await db.insert(tableName, calculation.toMap());
  }

  Future<List<Calculation>> readAllHistory() async {
    final db = await instance.database;

    final result = await db.query(
      tableName,
      orderBy: 'timestamp DESC',
    );

    return result.map((json) => Calculation.fromMap(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clearHistory() async {
    final db = await instance.database;
    return await db.delete(tableName);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
