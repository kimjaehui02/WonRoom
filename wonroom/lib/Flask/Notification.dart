import 'dart:convert';

class Notification {
  final String title;
  final String body;
  final DateTime date;
  final String? imageUrl;

  Notification({
    required this.title,
    required this.body,
    required this.date,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']),
      imageUrl: json['imageUrl'],
    );
  }
}
