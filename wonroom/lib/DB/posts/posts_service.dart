import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:wonroom/DB/posts/posts_model.dart'; // JSON 변환을 위해 import

// final Dio dio = Dio();
// final String baseUrl = "http://192.168.219.81:8087/";

class PostService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";

  // 게시글 추가 요청
  Future<void> addPost(Posts post) async {
    final String url = "$baseUrl/posts/insert";

    try {
      Response response = await dio.post(
        url,
        data: post.toJson(),  // Post 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 게시글 조회 요청 (예시)
  Future<List<Posts>?> getPosts(int userId) async {
    final String url = "$baseUrl/posts/select";

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          List<dynamic> plantsJson = responseData['data'];
          List<Posts> Postlist = plantsJson.map((json) => Posts.fromJson(json)).toList();
          print('Plant data retrieved successfully.');
          return Postlist;
        } else {
          print('Plant retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 게시글 수정 요청 (예시)
  Future<void> updatePost(Posts post) async {
    final String url = "$baseUrl/posts/update";

    try {
      Response response = await dio.put(
        url,
        data: post.toJson(),  // Post 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 게시글 삭제 요청 (예시)
  Future<void> deletePost(int postId) async {
    final String url = "$baseUrl/posts/delete";

    try {
      Response response = await dio.delete(
        url,
        data: {
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


// // 게시글 추가 요청
// Future<void> addPost({
//   required String postTitle,
//   required String postContent,
//   required String userId, // userId를 String으로 유지
//   String imageUrl = '',  // 선택적 필드
// }) async {
//   final String url = "$baseUrl/posts/insert";
//
//   print(DateTime.now().toIso8601String());
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: jsonEncode({
//         "post_title": postTitle,
//         "post_content": postContent,
//         "user_id": userId, // userId를 String으로 유지
//         "created_at": DateTime.now().toIso8601String(),
//         "image_url": imageUrl,   // 선택적 필드로 빈 문자열일 수 있음
//       }),
//       options: Options(
//         contentType: Headers.jsonContentType,
//       ),
//     );
//
//     print(response.statusCode);
//     print(response.realUri);
//     print(response.data);
//   } catch (e) {
//     print("Error: $e");
//   }
// }
