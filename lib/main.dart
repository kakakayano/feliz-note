import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';
import 'screens/calendar_screen.dart'; // カレンダー画面をインポート
// import 'screens/login_screen.dart'; // ログイン画面をインポート
import 'firebase_options.dart'; // FlutterFire CLIで生成されたファイル

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // 初期画面をログイン画面に設定
      routes: {
        '/': (context) => const HomeScreen(), // ホーム画面
        '/tasks': (context) => const TaskScreen(), // タスク画面
        '/calendar': (context) => const CalendarScreen(), // カレンダー画面を追加
        // '/login': (context) => const TaskScreen(), // ログイン画面（後に実装）
      },
    );
  }
}
