import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'lead_list_screen.dart';
import 'call_recording_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import '../services/notification_service.dart';

class HomeShellScreen extends StatefulWidget {
  final String role;
  final String userName;
  final String userEmail;

  const HomeShellScreen({
    super.key,
    required this.role,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _currentIndex = 0;
  final NotificationService _notificationService = NotificationService.instance;

  void _markAllUnreadDemo() {
    setState(() {
      _notificationService.markAllUnreadDemo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(role: widget.role, userName: widget.userName),
      LeadListScreen(role: widget.role, userName: widget.userName, userEmail: widget.userEmail),
      const CallRecordingScreen(),
      NotificationsScreen(onMarkAllUnread: _markAllUnreadDemo),
      ProfileScreen(role: widget.role, userName: widget.userName, userEmail: widget.userEmail),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 3) {
              _notificationService.markAllRead();
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Leads'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Calls'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications),
                if (_notificationService.unreadCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        _notificationService.unreadCount.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
