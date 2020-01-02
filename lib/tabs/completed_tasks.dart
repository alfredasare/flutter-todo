import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todos_provider.dart';
import '../widgets/task_list.dart';

class CompletedTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosProvider>(
        builder: (context, todos, _) => todos.completedTasks.isNotEmpty
            ? TaskList(
                tasks: todos.completedTasks,
              )
            : Center(
                child: Text(
                  'There are no completed tasks',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
      ),
    );
  }
}
