import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onTasksPressed;
  final VoidCallback onCalendarPressed;

  const Footer({
    super.key,
    required this.onHomePressed,
    required this.onTasksPressed,
    required this.onCalendarPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: onHomePressed, // ホームボタンの処理
            tooltip: 'ホーム',
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: onTasksPressed, // タスク管理ボタンの処理
            tooltip: 'タスク管理',
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today), // カレンダーアイコン
            onPressed: onCalendarPressed, // カレンダー画面ボタンの処理
            tooltip: 'カレンダー',
          ),
        ],
      ),
    );
  }
}
