import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart'; // 新しいタスク画面をインポート

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // 初期画面を設定
      routes: {
        '/': (context) => const HomeScreen(), // 初期画面
        '/tasks': (context) => const TaskScreen(), // タスク画面
      },
    );
  }
}
