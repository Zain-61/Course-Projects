import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/TaskProvider.dart';

class TaskStorage {
  static const String _tasksKey = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(_tasksKey, taskList);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList(_tasksKey) ?? [];
    return taskList.map((task) => Task.fromJson(jsonDecode(task))).toList();
  }
}