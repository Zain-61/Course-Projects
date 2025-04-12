import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../TaskStorage.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider() {
    print('TaskProvider constructor called');
    loadTasks(); // Call the loadTasks method here
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
  bool _tasksLoaded = false;

  Future<void> loadTasks() async {
    print('Loading tasks...');
    if (!_tasksLoaded) {
      _tasks = await TaskStorage.loadTasks();
      _tasksLoaded = true;
      print('Tasks loaded: $_tasks');
      notifyListeners();
    } else {
      print('Tasks already loaded');
    }
  }

  void addTask(String task) {
    _tasks.add(Task(title: task, isChecked: false));
    notifyListeners();
    _saveTasks();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
    _saveTasks();
  }

  void toggleTaskCheckState(int index) {
    _tasks[index].isChecked = !_tasks[index].isChecked;
    notifyListeners();
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    await TaskStorage.saveTasks(_tasks);
  }
}

class Task {
  String title;
  bool isChecked;

  Task({required this.title, required this.isChecked});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isChecked': isChecked,
    };
  }
}