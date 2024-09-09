import 'package:flutter/material.dart';

class Notifications {
  final String category;
  final String timeAgo;
  final String message;
  final String imagePath;

  Notifications({
    required this.category,
    required this.timeAgo,
    required this.message,
    required this.imagePath,
  });

  // JSON 변환 메서드 추가
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'timeAgo': timeAgo,
      'message': message,
      'imagePath': imagePath,
    };
  }

  // JSON에서 Notifications 객체로 변환하는 메서드 추가
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      category: json['category'],
      timeAgo: json['timeAgo'],
      message: json['message'],
      imagePath: json['imagePath'],
    );
  }
}
