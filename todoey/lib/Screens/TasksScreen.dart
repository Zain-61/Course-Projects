import 'package:flutter/material.dart';
import 'package:todoey/Widgets/ListTile.dart';
import 'package:todoey/Widgets/NewTasks.dart';
import 'package:provider/provider.dart';
import 'package:todoey/Widgets/TaskProvider.dart';
import '../TaskStorage.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    int TaskCount = 0;
    TaskCount = Provider.of<TaskProvider>(context).tasks.length;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: (){ showModalBottomSheet(context: context,builder: (context) => NewTasks());},
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 1),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 40, top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.list,
                        color: Colors.lightBlueAccent, size: 50),
                    radius: 35,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Todoey',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '$TaskCount Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: TaskList()),
            ),
          ],
        ),
      ),
    );
  }
  }
