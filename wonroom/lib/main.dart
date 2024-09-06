import 'dart:typed_data'; // Int64List를 사용하기 위한 import
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wonroom/PlantDetailPage.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // 알림 채널 설정
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'your_channel_id', // 채널 ID
    'your_channel_name', // 채널 이름
    description: 'Your channel description', // 채널 설명
    importance: Importance.max, // 중요도 설정
  );

  final AndroidFlutterLocalNotificationsPlugin androidFlutterLocalNotificationsPlugin =
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!;

  await androidFlutterLocalNotificationsPlugin.createNotificationChannel(channel);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      home: Splash(),
    );
  }
}

Future<void> showNotification() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // `const` 제거
  final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', // 채널 ID
    'your_channel_name', // 채널 이름
    importance: Importance.max, // 중요도
    priority: Priority.high, // 우선 순위
    vibrationPattern: Int64List.fromList([1000, 1000, 1000, 1000]), // 진동 패턴
    enableVibration: true, // 진동 활성화
    enableLights: true, // 조명 효과 활성화
    ticker: 'ticker', // 티커
  );

  final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  print('Showing notification...');
  await flutterLocalNotificationsPlugin.show(
    0,
    'Hello, Flutter!',
    'This is a test notification.',
    platformChannelSpecifics,
    payload: 'item x',
  );
  print('Notification shown.');
}
