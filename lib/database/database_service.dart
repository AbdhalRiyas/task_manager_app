import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._construct();
  static Database? _database;

  final String _tasksTable = 'tasks';
  final String _idColumn = 'id';
  final String _titleColumn = 'title';
  final String _descriptionColumn = 'description';

  factory DatabaseService() => instance;
  DatabaseService._construct();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks_database.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tasksTable (
          $_idColumn INTEGER PRIMARY KEY, 
          $_titleColumn TEXT, 
          $_descriptionColumn TEXT
          )''',
        );
      },
    );
    return database;
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    var result = await db.query(_tasksTable);
    return result.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert(_tasksTable, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(_tasksTable, task.toMap(),
        where: '$_idColumn = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db
        .delete(_tasksTable, where: '$_idColumn = ?', whereArgs: [id]);
  }
}
