import 'dart:async';
import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  final Map<DateTime, List<String>> _events = {}; // 日付ごとの予定を管理
  final Map<DateTime, Timer> _timers = {}; // タイムアウト用のタイマーを管理

  Map<DateTime, List<String>> get events => _events;

  /// 予定を追加
  void addEvent(
    DateTime date,
    String event, {
    Duration timeout = const Duration(minutes: 30),
  }) {
    final normalizedDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ); // UTCで正規化
    if (_events[normalizedDate] == null) {
      _events[normalizedDate] = [];
    }
    _events[normalizedDate]!.add(event);
    notifyListeners();

    // タイマーを設定して一定時間後にデータを削除
    _timers[normalizedDate]?.cancel(); // 既存のタイマーをキャンセル
    _timers[normalizedDate] = Timer(timeout, () {
      _events.remove(normalizedDate);
      _timers.remove(normalizedDate);
      notifyListeners();
    });
  }

  /// 予定を削除
  void removeEvent(DateTime date, String event) {
    final normalizedDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ); // UTCで正規化
    if (_events[normalizedDate] != null) {
      _events[normalizedDate]!.remove(event);
      if (_events[normalizedDate]!.isEmpty) {
        _events.remove(normalizedDate);
        _timers[normalizedDate]?.cancel();
        _timers.remove(normalizedDate);
      }
      notifyListeners();
    }
  }

  /// 全ての予定を取得
  List<String> getEventsForDay(DateTime date) {
    final normalizedDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
    ); // UTCで正規化
    return _events[normalizedDate] ?? [];
  }

  /// クラス破棄時にタイマーをキャンセル
  @override
  void dispose() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}
