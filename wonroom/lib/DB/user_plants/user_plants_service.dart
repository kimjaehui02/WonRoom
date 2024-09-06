import 'package:dio/dio.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/users/user_service.dart';


class UserPlantService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";

  // 식물 추가
  Future<void> addPlant(UserPlant userPlant) async {
    final String url = "$baseUrl/user_plants/insert";

    try {
      Response response = await dio.post(
        url,
        data: userPlant.toJson(),  // UserPlant 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          print('Plant added successfully.');
        } else {
          print('Plant addition failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // 새로운 함수: 식물 추가 후 ID 반환
  Future<int?> addPlantAndGetId(UserPlant userPlant) async {
    final String url = "$baseUrl/user_plants/insert_and_get_id";

    try {
      Response response = await dio.post(
        url,
        data: userPlant.toJson(),  // UserPlant 모델을 JSON으로 변환하여 전송
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          print('Plant added successfully.');
          int? plantId = responseData['plant_id'];
          print('New Plant ID: $plantId');
          return plantId;
        } else {
          print('Plant addition failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }

  // 식물 조회
  Future<List<UserPlant>?> getPlants(String userId) async {
    final String url = "$baseUrl/user_plants/select";

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
          List<UserPlant> plants = plantsJson.map((json) => UserPlant.fromJson(json)).toList();
          print('Plant data retrieved successfully.');
          return plants;
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

  // 식물 업데이트
  Future<void> updatePlant_diary_title(int plant_id, String diary_title) async {
    final String url = "$baseUrl/user_plants/update_diary_title";

    try {
      Response response = await dio.post(
        url,
        data: {
          "plant_id": plant_id,
          "diary_title": diary_title
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          print('Plant updated successfully.');
        } else {
          print('Plant update failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // 식물 업데이트
  Future<void> updatePlant_next_watering_date(int plant_id, DateTime next_watering_date) async {
    final String url = "$baseUrl/user_plants/update_watering_date";

    try {
      Response response = await dio.post(
        url,
        data: {
          "plant_id": plant_id,
          "next_watering_date": next_watering_date.toIso8601String(),
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          print('Plant updated successfully.');
        } else {
          print('Plant update failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  // 식물 삭제
  Future<void> deletePlant(int plantId) async {
    final String url = "$baseUrl/user_plants/delete";

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
          print('Plant deleted successfully.');
        } else {
          print('Failed to delete plant: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }



  Future<void> deletePlantRecords(int plantId) async {
    final String url = "$baseUrl/plant_management/delete_by_plant_id";

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
          print('Plant management records deleted successfully.');
        } else {
          print('Failed to delete plant records: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  // 식물과 관련된 기록을 삭제한 후 식물을 삭제하는 함수
  Future<void> deletePlantWithRecords(int plantId) async {
    try {
      // 1. 먼저 기록 삭제
      await deletePlantRecords(plantId);

      // 2. 기록 삭제 후 식물 삭제
      await deletePlant(plantId);
    } catch (e) {
      print("Error while deleting plant and records: $e");
    }
  }


}

