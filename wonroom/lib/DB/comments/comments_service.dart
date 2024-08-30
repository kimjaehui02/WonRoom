import 'package:dio/dio.dart';
import 'comments_model.dart';

class CommentService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";

  // 댓글 추가 요청
  Future<void> addComment(Comment comment) async {
    final String url = "$baseUrl/comments/insert";

    try {
      Response response = await dio.post(
        url,
        data: comment.toJson(),  // Comment 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 댓글 조회 요청
  Future<List<Comment>?> getComments(int postId) async {
    final String url = "$baseUrl/comments/select";

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
          List<dynamic> commentsJson = responseData['data'];
          List<Comment> commentsList = commentsJson.map((json) => Comment.fromJson(json)).toList();
          print('Comments data retrieved successfully.');
          return commentsList;
        } else {
          print('Comments retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 댓글 수정 요청
  Future<void> updateComment(Comment comment) async {
    final String url = "$baseUrl/comments/update";

    try {
      Response response = await dio.post(
        url,
        data: comment.toJson(),  // Comment 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 댓글 삭제 요청
  Future<void> deleteComment(int commentId) async {
    final String url = "$baseUrl/comments/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "comment_id": commentId,
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
