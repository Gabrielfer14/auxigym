import 'dart:ffi';
import 'package:auxigym/classes/ficha_tecnica.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'my_database.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<bool> checkCredentials(String username, String password) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'usuario',
      where: 'nome_usuario = ? AND senha_usuario = ?',
      whereArgs: [
        username,
        password
      ],
    );

    return result.isNotEmpty; // Retorna verdadeiro se encontrar um usuário com as credenciais fornecidas.
  }

  Future<bool> checkExistingUser(String username, String email) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'usuario',
      where: 'nome_usuario = ? OR email_usuario = ?',
      whereArgs: [
        username,
        email
      ],
    );

    return result.isNotEmpty; // Retorna verdadeiro se o nome de usuário ou email já existirem.
  }

  Future<void> insertUser(String username, String password, int age, String email) async {
    final db = await DatabaseHelper.instance.database;

    final user = <String, dynamic>{
      'nome_usuario': username,
      'senha_usuario': password,
      'idade_usuario': age,
      'email_usuario': email,
    };

    await db.insert('usuario', user); // Insere o usuário na tabela 'usuario'.
  }

  Future<int?> getUserId(String username) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'usuario',
      columns: [
        'id'
      ],
      where: 'nome_usuario = ?',
      whereArgs: [
        username
      ],
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    } else {
      return null; // Retorna null se nenhum usuário for encontrado com o nome de usuário fornecido.
    }
  }

  Future<String?> getUsername(int userId) async {
    final db = await DatabaseHelper.instance.database;
    final user = await db.query(
      'usuario',
      columns: [
        'nome_usuario'
      ],
      where: 'id = ?',
      whereArgs: [
        userId
      ],
    );

    if (user.isNotEmpty) {
      return user.first['nome_usuario'] as String?;
    }

    return null; // Retorna null se o usuário não for encontrado com base no userId.
  }

  Future<void> createFichaTecnica(int userId, Float peso, Float altura, String objetivo) async {
    final db = await DatabaseHelper.instance.database;

    // Crie um mapa com os valores da ficha técnica
    final fichaTecnica = <String, dynamic>{
      'altura': altura,
      'peso': peso,
      'objetivo_usuario': objetivo,
      'id_usuario': userId,
    };

    await db.insert('ficha_tecnica', fichaTecnica);
  }

  Future<FichaTecnica?> getFichaTecnica(int userId) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'ficha_tecnica',
      where: 'id_usuario = ?',
      whereArgs: [
        userId
      ],
    );
    if (maps.isNotEmpty) {
      return FichaTecnica.fromMap(maps.first);
    }
    return null;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_usuario);
    await db.execute(_fichatecnica);
    await db.execute(_exercicio);
    await db.execute(_treino);
    await db.execute(_conquistas);
    await db.execute(_notaspessoais);
    await db.execute(_listaamigos);
  }

  String get _usuario => '''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_usuario TEXT,
        senha_usuario TEXT,
        idade_usuario INTEGER,
        email_usuario TEXT UNIQUE
      );
    ''';

  String get _fichatecnica => '''
    CREATE TABLE ficha_tecnica (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      altura REAL,
      peso REAL,
      objetivo_usuario TEXT,
      id_usuario INTEGER REFERENCES usuario (id)
    );
  ''';
  String get _exercicio => '''
    CREATE TABLE Exercicio (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_exercicio TEXT,
      series INTEGER,
      repeticoes INTEGER,
      id_treino INTEGER REFERENCES Treino (id),
      anotacoes TEXT
    );
''';

  String get _treino => '''
    CREATE TABLE Treino (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      grupo_muscular TEXT,
      Divisao_de_treino TEXT,
      id_usuario INTEGER REFERENCES usuario (id)
    );
''';

  String get _conquistas => '''
    CREATE TABLE conquistas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_conquista TEXT,
      descricao TEXT,
      tipo_objetivo TEXT,
      valor_objetivo INTEGER,
      recompensa INTEGER,
      id_ficha INTEGER REFERENCES ficha_tecnica (id)
    );
''';

  String get _notaspessoais => '''
    CREATE TABLE notas_pessoais (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_usuario INTEGER REFERENCES usuario (id),
      data DATE,
      titulo TEXT,
      conteudo TEXT
    );
''';

  String get _listaamigos => '''
    CREATE TABLE lista_amigos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_amigo INTEGER REFERENCES usuario (id),
      id_usuario INTEGER REFERENCES usuario (id)
    );
    ''';
}
