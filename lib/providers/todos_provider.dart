import 'package:flutter/foundation.dart';
import 'dart:collection';
import '../models/task.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/database_helper.dart';
import 'package:flutter/material.dart';

class TodosProvider with ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> _tasks;
  int _count = 0;

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed == false));

  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed == true));

  void getTaskList() {
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = _databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        this._tasks = taskList;
        this._count = taskList.length;
        notifyListeners();
      });
    });
  }

  int get count => _count;

  void addTodo(Task task) async {
    int result;
    if (task.id != null) {
      result = await _databaseHelper.updateTask(task);
    } else {
      result = await _databaseHelper.insertTask(task);
    }
    if (result != 0) {
      print('Success');
    } else {
      print('Failed');
    }
//    getTaskList();
    notifyListeners();
  }

  void toggleTodo(BuildContext context, Task task) async {
    task.completed = !task.completed;
    int result = await _databaseHelper.updateTask(task);

    if (result != 0 && task.completed == true) {
      _showSnackBar(context, '${task.title} Completed');
    }
//    getTaskList();
    notifyListeners();
  }

  void deleteTodo(BuildContext context, Task task) async {
    if (task.id == null) {
      _showSnackBar(context, 'No task was deleted');
      return;
    }

    int result = await _databaseHelper.deleteTask(task.id);
    if (result != 0) {
      _showSnackBar(context, 'Task Deleted Successfully');
    } else {
      _showSnackBar(context, 'Error Occurred while deleting note');
    }
//    getTaskList();
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
