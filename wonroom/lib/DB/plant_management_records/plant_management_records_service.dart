import 'package:dio/dio.dart';
import 'package:wonroom/DB/plant_management_records/plant_management_model.dart';


class PlantManagementService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";  // 서버 URL

  // 레코드 추가 요청
  Future<void> addRecord(PlantManagementRecord record) async {
    final String url = "$baseUrl/plant_management/insert";

    try {
      Response response = await dio.post(
        url,
        data: record.toJson(),
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

// 레코드 조회 요청
  Future<List<PlantManagementRecord>> getRecords(int plantId) async {
    final String url = "$baseUrl/plant_management/select";

    try {
      Response response = await dio.post(
        url,
        data: {
          "plant_id": plantId,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          List<dynamic> recordsJson = responseData['data'];
          List<PlantManagementRecord> records = recordsJson
              .map((json) => PlantManagementRecord.fromJson(json))
              .toList();
          print('Records retrieved successfully.');
          return records;
        } else {
          print('Record retrieval failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    // 404 또는 오류 발생 시 빈 리스트 반환
    return [];
  }


  // 레코드 수정 요청
  Future<void> updateRecord(PlantManagementRecord record) async {
    final String url = "$baseUrl/plant_management/update";

    try {
      Response response = await dio.post(
        url,
        data: record.toJson(),
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error: $e");
    }
  }

  // 레코드 삭제 요청
  Future<void> deleteRecord(int recordId) async {
    final String url = "$baseUrl/plant_management/delete";

    try {
      Response response = await dio.post(
        url,
        data: {
          "record_id": recordId,
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
