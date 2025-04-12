import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskProvider.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    int index = taskProvider.tasks.indexOf(widget.task);

    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Task Removal"),
              content: Text("Are you sure you want to remove this task?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.lightBlueAccent),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Confirm", style: TextStyle(color: Colors.lightBlueAccent),),
                  onPressed: () {
                    taskProvider.removeTask(index);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      title: Text(
        widget.task.title,
        style: TextStyle(fontSize: 20, decoration: widget.task.isChecked ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Checkbox(
        value: widget.task.isChecked,
        onChanged: (newValue) {
          taskProvider.toggleTaskCheckState(index);
        },
        activeColor: Colors.lightBlueAccent,
      ),
    );
  }
}