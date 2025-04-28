import 'package:flutter/material.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  final List<String> tasks;
  final Function(int) onDelete; // 削除処理のコールバック関数

  const TaskList({
    super.key,
    required this.tasks,
    required this.onDelete, // コールバック関数を受け取る
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          taskName: tasks[index],
          onDelete: () => onDelete(index), // 削除処理を呼び出す
        );
      },
    );
  }
}
