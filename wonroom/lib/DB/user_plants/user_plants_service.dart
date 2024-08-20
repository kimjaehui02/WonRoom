

import 'package:dio/dio.dart';
import 'package:wonroom/DB/users/user_service.dart';

void addPlant(int user_id, int catalog_number, String diary_title, String next_watering_date) async {
  final String url = "$baseUrl/user_plants/insert";

  try {
    Response response = await dio.post(
      url,
      data: {
        "user_id": user_id,
        "catalog_number": catalog_number,
        "diary_title": diary_title,
        "next_watering_date": next_watering_date,
        "created_at": DateTime.now().toIso8601String(),  // 작성일 추가
      },
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


void getPlant(int plant_id) async {
  final String url = "$baseUrl/user_plants/select";

  try {
    Response response = await dio.get(url, queryParameters: {
      "plant_id": plant_id,
    });

    print('Status Code: ${response.statusCode}');
    print('Response URL: ${response.realUri}');
    print('Response Data: ${response.data}');

    if (response.statusCode == 200) {
      final responseData = response.data;
      if (responseData['status'] == 'success') {
        print('Plant data retrieved: ${responseData['data']}');
      } else {
        print('Plant retrieval failed: ${responseData['message']}');
      }
    } else {
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}

void updatePlant(int plant_id, int catalog_number, String diary_title, String next_watering_date) async {
  final String url = "$baseUrl/user_plants/update";

  try {
    Response response = await dio.post(
      url,
      data: {
        "plant_id": plant_id,
        "catalog_number": catalog_number,
        "diary_title": diary_title,
        "next_watering_date": next_watering_date,
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

void deletePlant(int plant_id) async {
  final String url = "$baseUrl/user_plants/delete";

  try {
    Response response = await dio.post(
      url,
      data: {
        "plant_id": plant_id,
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
        print('Plant deletion failed: ${responseData['message']}');
      }
    } else {
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}
