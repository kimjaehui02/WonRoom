import 'package:dio/dio.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 게시글 추가 요청
Future<void> addPost({
  required String postTitle,
  required String postContent,
  required int userId,
  String imageUrl = '',  // 선택적 필드
}) async {
  final String url = "$baseUrl/posts/insert";

  print(DateTime.now().toIso8601String());

  try {
    Response response = await dio.post(
      url,
      data: {
        "post_title": postTitle,
        "post_content": postContent,
        "user_id": userId,
        "created_at": DateTime.now().toIso8601String(),
        "image_url": imageUrl,   // 선택적 필드로 빈 문자열일 수 있음
      },
    );

    print(response.statusCode);
    print(response.realUri);
    print(response.data);
  } catch (e) {
    print("Error: $e");
  }
}
