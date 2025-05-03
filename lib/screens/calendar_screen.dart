import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/calendar_view.dart';
import '../widgets/event_list.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now(); // 現在の日付
  DateTime? _selectedDay; // 選択された日付
  final Map<DateTime, List<String>> _events = {}; // 日付ごとの予定を管理
  final TextEditingController _eventController =
      TextEditingController(); // テキストフィールド用コントローラー

  @override
  void dispose() {
    _eventController.dispose(); // メモリリークを防ぐためにdispose
    super.dispose();
  }

  void _addEvent() {
    if (_eventController.text.isEmpty || _selectedDay == null) return;

    setState(() {
      if (_events[_selectedDay] == null) {
        _events[_selectedDay!] = [];
      }
      _events[_selectedDay]!.add(_eventController.text); // 予定を追加
      _eventController.clear(); // テキストフィールドをクリア
    });

    Navigator.pop(context); // モーダルを閉じる
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'カレンダー'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarView(
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            const SizedBox(height: 16),
            EventList(
              selectedDay: _selectedDay,
              events: _events,
              eventController: _eventController,
              onAddEvent: _addEvent,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(
        onHomePressed: () {
          Navigator.pushReplacementNamed(context, '/'); // ホーム画面に遷移
        },
        onTasksPressed: () {
          Navigator.pushReplacementNamed(context, '/tasks'); // タスク管理画面に遷移
        },
        onCalendarPressed: () {
          Navigator.pushNamed(context, '/calendar'); // カレンダー画面に遷移
        },
      ),
    );
  }
}
