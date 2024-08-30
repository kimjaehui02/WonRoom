import 'dart:convert';

class QueryModel {
  int? queryId;
  String userId;
  DateTime createdAt;
  String queryType;
  String title;
  String content;
  int? parentQueryId;

  QueryModel({
    this.queryId,
    required this.userId,
    required this.createdAt,
    required this.queryType,
    required this.title,
    required this.content,
    this.parentQueryId,
  });

  // JSON으로부터 QueryModel 객체를 생성하는 팩토리 생성자
  factory QueryModel.fromJson(Map<String, dynamic> json) {
    return QueryModel(
      queryId: json['query_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      queryType: json['query_type'],
      title: json['title'],
      content: json['content'],
      parentQueryId: json['parent_query_id'],
    );
  }

  // QueryModel 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'query_id': queryId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'query_type': queryType,
      'title': title,
      'content': content,
      'parent_query_id': parentQueryId,
    };
  }

  // QueryModel 객체를 문자열로 변환하는 메서드 (디버깅용)
  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
