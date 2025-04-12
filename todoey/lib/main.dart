import 'package:flutter/material.dart';
import 'Screens/TasksScreen.dart';
import 'package:todoey/Widgets/TaskProvider.dart';
import 'package:provider/provider.dart' ;


void main() async{

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:TasksScreen());
  }
}
