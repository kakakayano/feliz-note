import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<String> _tasks = []; // タスクのリストを管理

  List<String> get tasks => _tasks;

  /// タスクを追加
  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
  }

  /// タスクを削除
  void removeTask(String task) {
    _tasks.remove(task);
    notifyListeners();
  }

  /// 全てのタスクを取得
  List<String> getAllTasks() {
    return _tasks;
  }
}
