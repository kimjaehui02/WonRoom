import 'package:intl/intl.dart';

class User {
  final String? userId;
  String? userPw;
  String? userNick;
  String? userEmail;
  DateTime regDate;
  int? favoritePlantId;

  User({
    required this.userId,
    required this.userPw,
    required this.userNick,
    required this.userEmail,
    required this.regDate,
    this.favoritePlantId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
    DateTime regDate = dateFormat.parse(json["reg_date"], true);

    return User(
      userId: json["user_id"],
      userPw: json["user_pw"],
      userNick: json["user_nick"],
      userEmail: json["user_email"],
      regDate: regDate,
      favoritePlantId: json["favorite_plant_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_pw": userPw,
    "user_nick": userNick,
    "user_email": userEmail,
    "reg_date": regDate.toIso8601String(),
    "favorite_plant_id": favoritePlantId,
  };

  String? getuserId() {
    return userId;
  }
}
