import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'happy_blindglish.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE progress (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            points INTEGER NOT NULL,
            words_learned INTEGER NOT NULL,
            last_updated TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertProgress(int points, int wordsLearned) async {
    final db = await database;
    return await db.insert(
      'progress',
      {
        'points': points,
        'words_learned': wordsLearned,
        'last_updated': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getProgress() async {
    final db = await database;
    final res = await db.query('progress', orderBy: 'id DESC', limit: 1);
    return res.isNotEmpty ? res.first : null;
  }

  Future<int> updateProgress(int points, int wordsLearned) async {
    final db = await database;
    return await db.update(
      'progress',
      {
        'points': points,
        'words_learned': wordsLearned,
        'last_updated': DateTime.now().toIso8601String(),
      },
      where: 'id = (SELECT MAX(id) FROM progress)',
    );
  }

  Future<void> deleteAllProgress() async {
    final db = await database;
    await db.delete('progress');
  }
}
