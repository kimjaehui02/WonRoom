import 'package:dio/dio.dart';
import 'package:wonroom/Flask/storage_manager.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 좋아요 추가 요청
Future<void> addLike({
  required int userId,
  required int postId,
}) async {
  final String url = "$baseUrl/likes/insert";

  try {
    Response response = await dio.post(
      url,
      data: {
        "user_id": userId,
        "post_id": postId,
        "created_at": DateTime.now().toIso8601String(),
      },
    );

    print(response.statusCode);
    print(response.realUri);
    print(response.data);
  } catch (e) {
    print("Error: $e");
  }
}
