import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/task_provider.dart'; // TaskProviderをインポート
import '../widgets/header.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context); // TaskProviderを取得

    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final todayEvents = calendarProvider.getEventsForDay(normalizedToday);
    final tasks = taskProvider.tasks; // 残タスクを取得

    return Scaffold(
      appBar: const Header(title: 'ホーム'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 今日の予定セクション
            const Text(
              '今日の予定',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (todayEvents.isEmpty)
              const Text(
                '今日の予定はありません。',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: todayEvents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todayEvents[index]),
                      leading: const Icon(Icons.event),
                    );
                  },
                ),
              ),
            const SizedBox(height: 32),

            // 残タスクセクション
            const Text(
              '残タスク',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (tasks.isEmpty)
              const Text(
                '残タスクはありません。',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]),
                      leading: const Icon(Icons.task),
                    );
                  },
                ),
              ),
          ],
        ),
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
