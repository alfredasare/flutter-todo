import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todos_provider.dart';
import '../widgets/task_list.dart';

class IncompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosProvider>(
        builder: (context, todos, _) => todos.incompleteTasks.isNotEmpty
            ? TaskList(
                tasks: todos.incompleteTasks,
              )
            : Center(
                child: Text(
                  'There are no incomplete tasks',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
      ),
    );
  }
}
