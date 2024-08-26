import 'dart:convert';

// User 클래스 정의
class User {
  String userId;
  String userPw;
  String userNick;
  String userEmail;  // Nullable 제거
  DateTime regDate;

  User({
    required this.userId,
    required this.userPw,
    required this.userNick,
    required this.userEmail,  // Nullable 제거
    required this.regDate,
  });

  // JSON에서 User 객체로 변환하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userPw: json["user_pw"],
    userNick: json["user_nick"],
    userEmail: json["user_email"] ?? '',  // Null 체크 후 기본값 제공
    regDate: DateTime.parse(json["reg_date"]),
  );

  // User 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_pw": userPw,
    "user_nick": userNick,
    "user_email": userEmail,
    "reg_date": regDate.toIso8601String(),
  };
}
