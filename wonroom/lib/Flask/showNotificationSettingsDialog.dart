import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showNotificationSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Notification Settings'),
        content: Text('Please enable notification settings for this app in your device settings.'),
        actions: [
          TextButton(
            onPressed: () {
              // 알림 설정 화면으로 이동
              openAppNotificationSettings();
            },
            child: Text('Go to Settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Future<void> openAppNotificationSettings() async {
  final Uri url = Uri.parse('app-settings:');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
