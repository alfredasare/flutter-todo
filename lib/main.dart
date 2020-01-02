import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/providers/todos_provider.dart';
import 'package:provider_app/screens/add_task.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodosProvider>(
          create: (_) => TodosProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SafeArea(
          child: Scaffold(
            body: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
