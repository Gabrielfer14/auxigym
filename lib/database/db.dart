import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  // Crie um mapa com os valores do usuário a serem inseridos.
  final user = <String, dynamic>{
    'nome_usuario': username,
    'senha_usuario': password,
    'idade_usuario': age,
    'email_usuario': email,
  };

  await db.insert('usuario', user); // Insere o usuário na tabela 'usuario'.
}

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

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_usuario TEXT,
      senha_usuario TEXT,
      idade_usuario INTEGER,
      email_usuario TEXT UNIQUE
    );

    CREATE TABLE ficha_tecnica (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      altura REAL,
      peso REAL,
      objetivo_usuario TEXT,
      id_usuario INTEGER REFERENCES usuario (id)
    );

    CREATE TABLE Exercicio (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_exercicio TEXT,
      series INTEGER,
      repeticoes INTEGER,
      id_treino INTEGER REFERENCES Treino (id),
      anotacoes TEXT
    );

    CREATE TABLE Treino (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      grupo_muscular TEXT,
      Divisao_de_treino TEXT,
      id_usuario INTEGER REFERENCES usuario (id)
    );

    CREATE TABLE conquistas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_conquista TEXT,
      descricao TEXT,
      tipo_objetivo TEXT,
      valor_objetivo INTEGER,
      recompensa INTEGER,
      id_ficha INTEGER REFERENCES ficha_tecnica (id)
    );

    CREATE TABLE notas_pessoais (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_usuario INTEGER REFERENCES usuario (id),
      data DATE,
      titulo TEXT,
      conteudo TEXT
    );

    CREATE TABLE lista_amigos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      id_amigo INTEGER REFERENCES usuario (id),
      id_usuario INTEGER REFERENCES usuario (id)
    );
  ''');
  }
}
