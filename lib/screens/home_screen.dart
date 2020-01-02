import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/providers/todos_provider.dart';
import 'package:provider_app/screens/add_task.dart';
import 'package:provider_app/tabs/all_tasks.dart';
import 'package:provider_app/tabs/completed_tasks.dart';
import 'package:provider_app/tabs/incomplete_tasks.dart';

class HomeScreen extends StatefulWidget {
  static bool hasData = false;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodosProvider>(context).getTaskList();

    if (Provider.of<TodosProvider>(context).count > 0) {
      HomeScreen.hasData = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTaskScreen()));
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Incomplete'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      body: Provider.of<TodosProvider>(context).count > 0
          ? TabBarView(
              controller: tabController,
              children: <Widget>[
                AllTasksTab(),
                IncompleteTasksTab(),
                CompletedTasksTab()
              ],
            )
          : Center(
              child: Text(
                '',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
    );
  }
}
