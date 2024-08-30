import 'package:dio/dio.dart';
import 'package:wonroom/DB/queries/queries_model.dart';


class QueryService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";  // 서버 URL

  // 질의 추가 요청
  Future<void> addQuery(QueryModel query) async {
    final String url = "$baseUrl/queries/insert";

    try {
      Response response = await dio.post(
        url,
        data: query.toJson(),  // Query 모델을 JSON으로 변환하여 전송
      );


      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 질의 조회 요청
  Future<List<QueryModel>?> getQueries(String userId) async {
    final String url = "$baseUrl/queries/select";

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
          List<dynamic> queriesJson = responseData['data'];
          List<QueryModel> queriesList = queriesJson.map((json) => QueryModel.fromJson(json)).toList();
          print('Query data retrieved successfully.');
          return queriesList;
        } else {
          print('Query retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 질의 수정 요청
  Future<void> updateQuery(QueryModel query) async {
    final String url = "$baseUrl/queries/update";

    try {
      Response response = await dio.post(
        url,
        data: query.toJson(),  // Query 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 질의 삭제 요청
  Future<void> deleteQuery(int queryId) async {
    final String url = "$baseUrl/queries/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "query_id": queryId,
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
