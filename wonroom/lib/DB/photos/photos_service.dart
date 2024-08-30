import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:wonroom/DB/photos/photos_model.dart'; // JSON 변환을 위해 import

class PhotoService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";

  // 사진 추가 요청
  Future<void> addPhoto(Photo photo) async {
    final String url = "$baseUrl/photos/insert";

    try {
      Response response = await dio.post(
        url,
        data: photo.toJson(),  // Photo 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 사진 조회 요청
  Future<List<Photo>?> getPhotos(int postId) async {
    final String url = "$baseUrl/photos/select";

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
          List<dynamic> photosJson = responseData['data'];
          List<Photo> photoList = photosJson.map((json) => Photo.fromJson(json)).toList();
          print('Photo data retrieved successfully.');
          return photoList;
        } else {
          print('Photo retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 사진 수정 요청
  Future<void> updatePhoto(Photo photo) async {
    final String url = "$baseUrl/photos/update";

    try {
      Response response = await dio.post(
        url,
        data: photo.toJson(),  // Photo 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 사진 삭제 요청
  Future<void> deletePhoto(int photoId) async {
    final String url = "$baseUrl/photos/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "photo_id": photoId,
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
