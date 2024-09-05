
class Comment {
  int? commentId;
  int postId;
  String userId;
  String commentContent;
  DateTime createdAt;
  int? parentCommentId;
  bool isReply;

  Comment({
    this.commentId,
    required this.postId,
    required this.userId,
    required this.commentContent,
    required this.createdAt,
    this.parentCommentId,
    this.isReply = false,
  });

  // JSON에서 Comment 객체를 생성하는 팩토리 생성자
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json['comment_id'] as int?,
    postId: json['post_id'] as int,
    userId: json['user_id'] as String,
    commentContent: json['comment_content'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    parentCommentId: json['parent_comment_id'] as int?,
    isReply: json['is_reply'] as bool? ?? false,
  );

  // Comment 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => {
    'comment_id': commentId,
    'post_id': postId,
    'user_id': userId,
    'comment_content': commentContent,
    'created_at': createdAt.toIso8601String(),
    'parent_comment_id': parentCommentId,
    'is_reply': isReply,
  };

  @override
  String toString() {
    return 'Comment{commentId: $commentId, postId: $postId, userId: $userId, commentContent: $commentContent, createdAt: $createdAt, parentCommentId: $parentCommentId, isReply: $isReply}';
  }
}
