import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final DateTime? selectedDay;
  final Map<DateTime, List<String>> events;
  final TextEditingController eventController;
  final VoidCallback onAddEvent;

  const EventList({
    super.key,
    required this.selectedDay,
    required this.events,
    required this.eventController,
    required this.onAddEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedDay != null)
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: eventController,
                            decoration: const InputDecoration(
                              labelText: '予定を入力してください',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: onAddEvent,
                            child: const Text('予定を追加'),
                          ),
                        ],
                      ),
                    ),
              );
            },
            child: const Text('予定を追加'),
          ),
        const SizedBox(height: 16),
        if (selectedDay != null && events[selectedDay] != null)
          ...events[selectedDay]!.map((event) => ListTile(title: Text(event))),
      ],
    );
  }
}
