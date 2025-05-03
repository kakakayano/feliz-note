import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Providerをインポート
import '../providers/calendar_provider.dart'; // CalendarProviderをインポート
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
  final TextEditingController _eventController =
      TextEditingController(); // テキストフィールド用コントローラー

  @override
  void dispose() {
    _eventController.dispose(); // メモリリークを防ぐためにdispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(
      context,
    ); // CalendarProviderを取得

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
              events: calendarProvider.events, // CalendarProviderから予定を取得
              eventController: _eventController,
              onAddEvent: () {
                if (_eventController.text.isEmpty || _selectedDay == null)
                  return;

                calendarProvider.addEvent(
                  _selectedDay!,
                  _eventController.text,
                ); // CalendarProviderに予定を追加
                _eventController.clear(); // テキストフィールドをクリア
                Navigator.pop(context); // モーダルを閉じる
              },
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
          Navigator.pushReplacementNamed(context, '/calendar'); // カレンダー画面に遷移
        },
      ),
    );
  }
}
