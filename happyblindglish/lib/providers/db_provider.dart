import 'package:happyblindglish/global/banco_palabras.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String _databaseName = "app_database.db";
  static const int _databaseVersion = 3;

  // Singleton para evitar múltiples instancias de la base de datos
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;
  DatabaseProvider._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Crear las tablas
  Future<void> _onCreate(Database db, int version) async {
    // Tabla de usuarios
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        edad INTEGER NOT NULL,
        puntos INTEGER NOT NULL,
        nivel INTEGER NOT NULL
      )
    ''');

    // Tabla de lecciones
    await db.execute('''
      CREATE TABLE lecciones (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        tema TEXT NOT NULL,
        descripcion TEXT,
        dificultad INTEGER
      )
    ''');

    // Tabla de retos
    await db.execute('''
      CREATE TABLE retos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        tipo TEXT NOT NULL,
        tema TEXT,
        descripcion TEXT,
        estatusCompletado INTEGER NOT NULL, -- 0 para false, 1 para true
        puntosReto INTEGER NOT NULL,
        palabrasPorAprender INTEGER NOT NULL,
        palabrasAprendidas INTEGER NOT NULL
      )
    ''');

    // Tabla de palabras
    await db.execute('''
      CREATE TABLE palabras (
        palabraEspanol TEXT PRIMARY KEY NOT NULL,
        palabraIngles TEXT NOT NULL,
        tipo TEXT NOT NULL,
        nivel INTEGER NOT NULL,
        aprendido INTEGER NOT NULL -- 0 para false, 1 para true
      )
    ''');
  }

  // Métodos para insertar datos
  Future<void> insertarBancoDePalabras() async {
    for (var palabra in BancoPalabras.bancoTraducciones) {
      await insertPalabra(
        palabra.toMap(),
      );
    }
  }

  Future<void> insertUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.insert('usuarios', usuario);
  }

  Future<void> insertLeccion(Map<String, dynamic> leccion) async {
    final db = await database;
    await db.insert('lecciones', leccion);
  }

  Future<void> insertReto(Map<String, dynamic> reto) async {
    final db = await database;
    await db.insert('retos', reto);
  }

  Future<void> insertPalabra(Map<String, dynamic> palabra) async {
    final db = await database;
    await db.insert('palabras', palabra,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Métodos para obtener datos
  Future<List<Map<String, dynamic>>> getPalabrasNoAprendidas(
      String tema, int nivel) async {
    final db = await database;
    return await db.query(
      'palabras',
      where: 'tipo = ? AND aprendido = 0 AND nivel = ?',
      whereArgs: [tema, nivel],
    );
  }

  Future<List<Map<String, dynamic>>> getAllPalabrasByTheme(
      String tema, int nivel) async {
    final db = await database;
    return await db.query(
      'palabras',
      where: 'tipo = ? AND nivel = ?',
      whereArgs: [tema, nivel],
    );
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    final db = await database;
    return await db.query('usuarios');
  }

  Future<List<Map<String, dynamic>>> getLecciones() async {
    final db = await database;
    return await db.query('lecciones');
  }

  Future<List<Map<String, dynamic>>> getRetos() async {
    final db = await database;
    return await db.query('retos');
  }

  Future<List<Map<String, dynamic>>> getPalabras() async {
    final db = await database;
    return await db.query('palabras');
  }

  // Métodos para actualizar datos
  Future<void> updatePalabra(
      String palabraEspanol, Map<String, dynamic> palabra) async {
    final db = await database;
    await db.update('palabras', palabra,
        where: 'palabraEspanol = ?', whereArgs: [palabraEspanol]);
  }

  // Métodos para eliminar datos
  Future<void> deletePalabra(String palabraEspanol) async {
    final db = await database;
    await db.delete('palabras',
        where: 'palabraEspanol = ?', whereArgs: [palabraEspanol]);
  }
}
