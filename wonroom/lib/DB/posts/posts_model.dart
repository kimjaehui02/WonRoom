import 'dart:convert';

// Post 모델 클래스
class Posts {
  int? postId;
  final String postTitle;
  final String postContent;
  final String userId;
  final DateTime createdAt;
  String? imageUrl;

  // 생성자
  Posts({
    this.postId,
    required this.postTitle,
    required this.postContent,
    required this.userId,
    required this.createdAt,
    this.imageUrl,
  });

  // JSON에서 Post 객체로 변환
  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      postId: json['post_id'],
      postTitle: json['post_title'],
      postContent: json['post_content'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image_url'],
    );
  }

  // Post 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'post_title': postTitle,
      'post_content': postContent,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'image_url': imageUrl,
    };
  }
}
