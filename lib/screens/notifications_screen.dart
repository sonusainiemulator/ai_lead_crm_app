import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatelessWidget {
  final VoidCallback? onMarkAllUnread;
  final NotificationService _notificationService = NotificationService.instance;

  const NotificationsScreen({super.key, this.onMarkAllUnread});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockNotifications = [
      {
        'title': 'Follow-up due: Alice Smith',
        'subtitle': 'Call scheduled today at 4:30 PM',
        'time': '10m ago',
      },
      {
        'title': 'New high-priority lead',
        'subtitle': 'Daniel Green scored 93% in AI scoring',
        'time': '30m ago',
      },
      {
        'title': 'Recording uploaded to CRM',
        'subtitle': 'mock_recording.aac attached to L-1001',
        'time': '1h ago',
      },
      {
        'title': 'Reminder: Send proposal',
        'subtitle': 'Rohan Patel requested final quote',
        'time': '2h ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              _notificationService.markAllUnreadDemo();
              if (onMarkAllUnread != null) {
                onMarkAllUnread!();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo unread alerts restored.')),
              );
            },
            child: const Text(
              'Mark all unread',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: mockNotifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = mockNotifications[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_active),
              title: Text(item['title'] ?? ''),
              subtitle: Text(item['subtitle'] ?? ''),
              trailing: Text(item['time'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
