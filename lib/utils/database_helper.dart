import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider_app/models/task.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String todosTable = 'todos_table';
  String colId = 'id';
  String colTitle = 'title';
  String colCompleted = 'completed';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  //  Database Getter
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos.db';

    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todosTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colCompleted INTEGER)');
  }

  //  FETCH
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;
    var result = await db.query(todosTable);
    return result;
  }

  //  INSERT
  Future<int> insertTask(Task task) async {
    Database db = await this.database;
    var result = await db.insert(todosTable, task.toMap());
    return result;
  }

  //  UPDATE
  Future<int> updateTask(Task task) async {
    Database db = await this.database;
    var result = await db.update(todosTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  //  DELETE
  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $todosTable WHERE $colId = $id');
    return result;
  }

  //  Get Number of objects in DB
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $todosTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Converting MapList to TaskList
  Future<List<Task>> getTaskList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<Task> taskList = List<Task>();

    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMapObject(todoMapList[i]));
    }
    return taskList;
  }
}
