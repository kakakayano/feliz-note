import 'package:flutter/material.dart';
import '../widgets/task_list.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                controller: _taskController,
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
                      _tasks.add(taskName);
                    });
                    _taskController.clear();
                    Navigator.pop(context);
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
      appBar: Header(title: 'タスク管理'),
      body: TaskList(
        tasks: _tasks,
        onDelete: (index) {
          setState(() {
            _tasks.removeAt(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
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
