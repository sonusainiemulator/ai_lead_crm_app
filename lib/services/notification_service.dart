class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  int _unreadCount = 4;

  int get unreadCount => _unreadCount;

  void markAllRead() {
    _unreadCount = 0;
  }

  void markAllUnreadDemo([int count = 4]) {
    _unreadCount = count;
  }
}
