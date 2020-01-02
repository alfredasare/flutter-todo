import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todos_provider.dart';
import '../models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (bool checked) async {
          Provider.of<TodosProvider>(context, listen: false)
              .toggleTodo(context, task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        onPressed: () {
          Provider.of<TodosProvider>(context, listen: false)
              .deleteTodo(context, task);
        },
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
