import 'package:flutter/material.dart';
import 'package:todoey/Widgets/TaskList.dart';
import 'package:provider/provider.dart';
import 'TaskProvider.dart';

class NewTasks extends StatefulWidget {
  const NewTasks({super.key});

  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Add Task',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 40,
              ),
            ),
          ),
          TextField(
            controller: _controller,
            autofocus: true,
            textAlign: TextAlign.center,
            cursorColor: Colors.lightBlueAccent,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 4),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Colors.lightBlueAccent),
              minimumSize: MaterialStateProperty.all(Size.fromHeight(60)),
            ),
            onPressed: () {
              setState(() {
                if (_controller.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(_controller.text);
                  Navigator.pop(context);
                }
              });
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}