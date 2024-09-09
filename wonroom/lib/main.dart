// import 'dart:typed_data'; // Int64List를 사용하기 위한 import
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzData; // 타임존 데이터 패키지
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wonroom/splash.dart'; // 권한 요청 패키지
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // 타임존 초기화
//   tzData.initializeTimeZones();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   // 알림 채널 설정
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'your_channel_id', // 채널 ID
//     'your_channel_name', // 채널 이름
//     description: 'Your channel description', // 채널 설명
//     importance: Importance.max, // 중요도 설정
//     playSound: true, // 소리 재생 설정
//   );
//
//   final AndroidFlutterLocalNotificationsPlugin androidFlutterLocalNotificationsPlugin =
//   flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!;
//
//   await androidFlutterLocalNotificationsPlugin.createNotificationChannel(channel);
//
//   // 권한 요청 (Android 12 이상에서 필요한 권한 요청)
//   await requestPermissions();
//
//   runApp(const MyApp());
// }
//
// Future<void> requestPermissions() async {
//   // 알림 권한 요청
//   final notificationStatus = await Permission.notification.status;
//   if (notificationStatus.isDenied) {
//     final newStatus = await Permission.notification.request();
//     if (newStatus.isDenied) {
//       print('Notification permission denied');
//     } else {
//       print('Notification permission granted');
//     }
//   } else {
//     print('Notification permission already granted');
//   }
//
//   // 정확한 알람 권한 요청 (Android 12 이상)
//   final alarmStatus = await Permission.scheduleExactAlarm.status;
//   if (alarmStatus.isDenied) {
//     final newStatus = await Permission.scheduleExactAlarm.request();
//     if (newStatus.isDenied) {
//       print('Exact Alarm permission denied');
//     } else {
//       print('Exact Alarm permission granted');
//     }
//   } else {
//     print('Exact Alarm permission already granted');
//   }
// }
//
// Future<void> scheduleNotification() async {
//   try {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id', // 채널 ID
//       'your_channel_name', // 채널 이름
//       importance: Importance.max, // 중요도
//       priority: Priority.high, // 우선 순위
//       vibrationPattern: Int64List.fromList([1000, 1000, 1000, 1000]), // 진동 패턴
//       enableVibration: true, // 진동 활성화
//       enableLights: true, // 조명 효과 활성화
//       ticker: 'ticker', // 티커
//       playSound: true, // 소리 재생 설정
//     );
//
//     final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     // 현재 시간으로부터 10초 후에 알림 예약
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     final tz.TZDateTime scheduledDate = now.add(Duration(seconds: 10));
//
//     // 로컬 시간으로 변환하여 로그 출력
//     print('Attempting to schedule notification for: ${scheduledDate}');
//     print('Current time is: ${now}');
//     print('Current local time is: ${now.toLocal()}'); // 로컬 시간 출력
//     print('Scheduled time in local time: ${scheduledDate.toLocal()}'); // 로컬 시간으로 변환된 예약 시간 출력
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Scheduled Notification',
//       'This notification was scheduled to appear in the future.',
//       scheduledDate,
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true, // 앱이 백그라운드에 있어도 알림이 표시되도록 설정
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     );
//
//     print('Notification scheduled successfully for ${scheduledDate}');
//   } catch (e) {
//     print('Failed to schedule notification: $e');
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Pretendard',
//         scaffoldBackgroundColor: Colors.white,
//         primaryColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: Text('Notification Example')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               // 즉시 알림 테스트
//               await testNotification();
//               // 알림 예약 함수 호출
//               await scheduleNotification();
//             },
//             child: Text('Schedule Notification'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> testNotification() async {
//   try {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       vibrationPattern: Int64List.fromList([1000, 1000, 1000, 1000]),
//       enableVibration: true,
//       enableLights: true,
//       ticker: 'ticker',
//       playSound: true,
//     );
//
//     final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Test Notification',
//       'This is a test notification.',
//       platformChannelSpecifics,
//     );
//
//     print('Test notification displayed successfully');
//   } catch (e) {
//     print('Failed to display test notification: $e');
//   }
// }

import 'package:flutter/material.dart';
import 'package:wonroom/Splash/splash_functions.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart';
import 'package:wonroom/myPlantNull.dart';
import 'package:wonroom/notificationNulll.dart';
import 'package:wonroom/notificationPage.dart';
import 'splash.dart'; // Splash 위젯을 불러옵니다.

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: NotificationWrapper(), // 직접 Splash 위젯을 호출
    ),
  );

  // 나중에 알림 시스템 로직으로 돌아가려면 이 부분을 주석 처리하거나, 별도의 함수를 사용하여 복원 가능
  // scheduleNotification(); // 여기에 알림 시스템 복원 로직을 추가할 수 있습니다.
}

