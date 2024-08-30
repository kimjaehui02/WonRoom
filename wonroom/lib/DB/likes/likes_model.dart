import 'dart:convert';

class Like {
  int? likeId;
  final String userId;
  final int postId;
  final DateTime createdAt;

  Like({
    this.likeId,
    required this.userId,
    required this.postId,
    required this.createdAt,
  });

  // JSON에서 Like 객체로 변환
  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likeId: json['like_id'],
      userId: json['user_id'],
      postId: json['post_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Like 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'like_id': likeId,
      'user_id': userId,
      'post_id': postId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // JSON 배열을 List<Like>로 변환
  static List<Like> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Like.fromJson(json)).toList();
  }

  // List<Like>를 JSON 배열로 변환
  static String toJsonList(List<Like> likes) {
    final List<Map<String, dynamic>> jsonList = likes.map((like) => like.toJson()).toList();
    return json.encode(jsonList);
  }
}
