import 'package:dio/dio.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 댓글 추가 요청
Future<void> addComment({
  required int postId,
  required int userId,
  required String commentContent,
  int? parentCommentId,
  bool isReply = false,
}) async {
  final String url = "$baseUrl/comments/insert";

  try {
    Response response = await dio.post(
      url,
      data: {
        "post_id": postId,
        "user_id": userId,
        "comment_content": commentContent,
        "created_at": DateTime.now().toIso8601String(),  // 날짜를 ISO8601 문자열로 변환
        "parent_comment_id": parentCommentId ?? null,  // 부모 댓글 ID가 없을 경우 null
        "is_reply": isReply ? 1 : 0,  // bool 값을 int(1 또는 0)로 변환
      },
    );

    print(response.statusCode);
    print(response.realUri);
    print(response.data);
  } catch (e) {
    print("Error: $e");
  }
}
