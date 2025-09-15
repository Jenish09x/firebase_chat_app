part of '../core.dart';

@pragma('vm:entry-point')
class NotificationHelper {
  static final instance = NotificationHelper._();

  NotificationHelper._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  final String _vapidKey = 'BHtVhnKUxyeKiViktRV2MveGy3Ti-18nJI9DGjDiTRr08BlH2Fp4wI1M5ecvjcIqf0wi_x_DxVi35pTitYbsFOA';

  Future<void> init() async {
    await _requestPermissions();

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    await _initLocalNotifications();

    final token = await _messaging.getToken(vapidKey: _vapidKey);
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);

    final initialMsg = await _messaging.getInitialMessage();
    if (initialMsg != null) _handleNotificationClick(initialMsg);
  }

  Future<void> _requestPermissions() async {
    await Permission.notification.request();
    await _messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final screen = details.payload;
        if (screen != null && screen.isNotEmpty) {
          _navigateTo(screen);
        }
      },
    );
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    print('Background message: ${message.data}');
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground: ${message.notification?.title} - ${message.notification?.body}');
    _showLocalNotification(message);
  }

  void _handleNotificationClick(RemoteMessage message) {
    final screen = message.data['screen'];
    if (screen != null) {
      _navigateTo(screen);
    }
  }

  void _navigateTo(String screen) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushNamed(screen);
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'Default',
      channelDescription: 'Default notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      notificationDetails,
      payload: message.data['screen'],
    );
  }
}
