import 'dart:convert';
import 'package:intl/intl.dart';

class User {
  final String? userId;
  String? userPw;
  String? userNick;
  String? userEmail;
  DateTime regDate;
  String? favoritePlantId; // 추가된 필드

  User({
    required this.userId,
    required this.userPw,
    required this.userNick,
    required this.userEmail,
    required this.regDate,
    this.favoritePlantId, // 선택적 필드
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // 날짜 형식 변환을 위한 DateFormat 객체 생성
    final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");

    // JSON에서 날짜 문자열을 파싱하여 DateTime 객체로 변환
    DateTime regDate = dateFormat.parse(json["reg_date"], true);

    return User(
      userId: json["user_id"],
      userPw: json["user_pw"],
      userNick: json["user_nick"],
      userEmail: json["user_email"],
      regDate: regDate,
      favoritePlantId: json["favorite_plant_id"], // 추가된 필드
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_pw": userPw,
    "user_nick": userNick,
    "user_email": userEmail,
    "reg_date": regDate.toIso8601String(),  // DateTime을 ISO 8601 문자열로 변환
    "favorite_plant_id": favoritePlantId, // 추가된 필드
  };

  String? getuserId() {
    return userId;
  }
}
