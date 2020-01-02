import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/models/task.dart';
import 'package:provider_app/providers/todos_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskTitleController = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Task todo = Task(title: textVal, completed: completed);
      Provider.of<TodosProvider>(context, listen: false).addTodo(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: taskTitleController,
                  ),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) {
                      setState(() {
                        completedStatus = checked;
                      });
                    },
                    title: Text('Complete ?'),
                  ),
                  RaisedButton(
                    elevation: 5.0,
                    child: Text('Add'),
                    onPressed: onAdd,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
