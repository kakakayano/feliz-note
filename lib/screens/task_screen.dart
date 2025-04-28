import 'package:flutter/material.dart';
import '../widgets/task_list.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<String> _tasks = []; // タスクのリスト
  final TextEditingController _taskController =
      TextEditingController(); // クラスのフィールドとして定義

  @override
  void dispose() {
    _taskController.dispose(); // メモリリークを防ぐためにdisposeを呼び出す
    super.dispose();
  }

  void _addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // モーダルの高さを調整可能にする
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom, // キーボード分の余白を確保
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '新しいタスクを追加',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _taskController, // クラスのフィールドを使用
                decoration: const InputDecoration(
                  labelText: 'タスク名',
                  border: OutlineInputBorder(),
                  hintText: 'タスクを入力してください',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final taskName = _taskController.text.trim();
                  if (taskName.isNotEmpty) {
                    setState(() {
                      _tasks.add(taskName); // タスクリストに追加
                    });
                    _taskController.clear(); // 入力フィールドをクリア
                    Navigator.pop(context); // モーダルを閉じる
                  }
                },
                child: const Text('追加'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: TaskList(
        tasks: _tasks,
        onDelete: (index) {
          setState(() {
            _tasks.removeAt(index); // タスクを削除
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask, // モーダルを開く
        child: const Icon(Icons.add),
      ),
    );
  }
}
