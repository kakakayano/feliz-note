import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete; // 削除処理のコールバック関数

  const TaskItem({
    super.key,
    required this.taskName,
    required this.onDelete, // コールバック関数を受け取る
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskName),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete, // 削除処理を実行
      ),
    );
  }
}
