import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todos_provider.dart';
import '../widgets/task_list.dart';

class AllTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosProvider>(
        builder: (context, todos, _) => todos.allTasks.isNotEmpty
            ? TaskList(
                tasks: todos.allTasks,
              )
            : Center(
                child: Text(
                  'There are no tasks',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
      ),
    );
  }
}
