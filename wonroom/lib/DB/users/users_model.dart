import 'dart:convert';

// 함수: JSON 문자열을 List<User>로 변환
List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

// 함수: List<User>를 JSON 문자열로 변환
String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int userId;
  String userPw;
  String userNick;
  String? userEmail; // Nullable
  DateTime regDate;

  User({
    required this.userId,
    required this.userPw,
    required this.userNick,
    this.userEmail,
    required this.regDate,
  });

  // JSON에서 User 객체로 변환하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userPw: json["user_pw"],
    userNick: json["user_nick"],
    userEmail: json["user_email"],
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
