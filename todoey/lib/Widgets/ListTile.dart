import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'TaskProvider.dart';



class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    print('TaskList build method called');
    final taskProvider = Provider.of<TaskProvider>(context);
    print('TaskProvider instance: $taskProvider');

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(task: taskProvider.tasks[index]);
            },
          ),
        ),
      ],
    );
  }
}