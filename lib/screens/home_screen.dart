import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'ホーム'),
      body: const Center(child: Text('ホーム画面')),
      bottomNavigationBar: Footer(
        onHomePressed: () {
          Navigator.pushReplacementNamed(context, '/'); // ホーム画面に遷移
        },
        onTasksPressed: () {
          Navigator.pushNamed(context, '/tasks'); // タスク管理画面に遷移
        },
        onCalendarPressed: () {
          Navigator.pushNamed(context, '/calendar'); // カレンダー画面に遷移
        },
      ),
    );
  }
}
