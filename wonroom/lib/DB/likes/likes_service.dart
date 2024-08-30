import 'package:dio/dio.dart';
import 'likes_model.dart';

class LikeService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";  // Flask 서버 URL

  // 좋아요 추가 요청
  Future<void> addLike(Like like) async {
    final String url = "$baseUrl/likes/insert";

    try {
      Response response = await dio.post(
        url,
        data: like.toJson(),  // Like 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 특정 게시물의 좋아요 조회 요청
  Future<List<Like>?> getLikes(int postId) async {
    final String url = "$baseUrl/likes/select";

    try {
      Response response = await dio.post(
        url,
        data: {
          "post_id": postId,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          List<dynamic> likesJson = responseData['data'];
          List<Like> likesList = likesJson.map((json) => Like.fromJson(json)).toList();
          print('Likes data retrieved successfully.');
          return likesList;
        } else {
          print('Likes retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 좋아요 삭제 요청
  Future<void> removeLike(String userId, int postId) async {
    final String url = "$baseUrl/likes/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
          "post_id": postId,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }
}
