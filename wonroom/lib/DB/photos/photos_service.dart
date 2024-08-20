import 'package:dio/dio.dart';
import 'package:wonroom/Flask/storage_manager.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 사진 추가 요청
Future<void> addPhoto({
  required int postId,
  required String category,
  required bool isPrimary,
  required String fileName,
  required String serverPath,
  required String fileType,
}) async {
  final String url = "$baseUrl/photos/insert";

  try {
    Response response = await dio.post(
      url,
      data: {
        "post_id": postId,
        "category": category,
        "is_primary": isPrimary ? 1 : 0,  // bool 값을 int(1 또는 0)로 변환
        "file_name": fileName,
        "server_path": serverPath,
        "file_type": fileType,
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
