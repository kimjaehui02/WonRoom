import 'package:dio/dio.dart';
import 'package:wonroom/DB/user_plants/user_plants_model.dart';
import 'package:wonroom/DB/users/user_service.dart';

// void addPlant(String user_id, int catalog_number, String diary_title, next_watering_date) async {
//   final String url = "$baseUrl/user_plants/insert";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "user_id": user_id,
//         "catalog_number": catalog_number,
//         "diary_title": diary_title,
//         "next_watering_date": next_watering_date,
//         "created_at": DateTime.now().toIso8601String(),  // 작성일 추가
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//       if (responseData['status'] == 'success') {
//         print('Plant added successfully.');
//       } else {
//         print('Plant addition failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }


// void getPlants(String? user_id) async {
//   final String url = "$baseUrl/user_plants/select";
//
//   if(user_id == null)
//     {
//       print("값이 null입니다");
//       return;
//     }
//
//   try {
//     Response response = await dio.get(url, queryParameters: {
//       "user_id": user_id,
//     });
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//       if (responseData['status'] == 'success') {
//         print('Plant data retrieved: ${responseData['data']}');
//       } else {
//         print('Plant retrieval failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

// void updatePlant(int plant_id, int catalog_number, String diary_title, String next_watering_date) async {
//   final String url = "$baseUrl/user_plants/update";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "plant_id": plant_id,
//         "catalog_number": catalog_number,
//         "diary_title": diary_title,
//         "next_watering_date": next_watering_date,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//       if (responseData['status'] == 'success') {
//         print('Plant updated successfully.');
//       } else {
//         print('Plant update failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

// void deletePlant(int plant_id) async {
//   final String url = "$baseUrl/user_plants/delete";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "plant_id": plant_id,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//       if (responseData['status'] == 'success') {
//         print('Plant deleted successfully.');
//       } else {
//         print('Plant deletion failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }


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
          print('Plant deletion failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
