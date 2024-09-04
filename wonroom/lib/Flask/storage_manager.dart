import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wonroom/DB/users/users_model.dart';

final storage = FlutterSecureStorage();


// 데이터 저장 함수
Future<void> writeData(String key, String value) async {
  print('writeData');
  try {
    await storage.write(key: key, value: value);
    print('Data written successfully.');
  } catch (e) {
    print('Error writing data: $e');
  }
}

Future<void> writeUserData(Map<String, dynamic> value) async {
  print('writeUserData');
  try {
    // Map을 JSON 문자열로 변환하여 저장
    String jsonString = jsonEncode(value);
    await storage.write(key: 'userData', value: jsonString);
    print('Data written successfully.');
  } catch (e) {
    print('Error writing data: $e');
  }
}




// 데이터 읽기 함수
Future<String?> readData(String key) async {
  print('readData');
  try {
    String? value = await storage.read(key: key);
    print('Data read successfully: $value');
    return value;
  } catch (e) {
    print('Error reading data: $e');
    return null;
  }
}

// 데이터 읽기 함수 (int 반환)
Future<int?> readDataAsInt(String key) async {
  print('readDataAsInt');
  try {
    // 데이터 읽기
    String? value = await storage.read(key: key);
    print('Data read successfully: $value');

    // String을 int로 변환 (변환 실패 시 null 반환)
    if (value == null) {
      return null;
    }

    return int.tryParse(value);
  } catch (e) {
    print('Error reading data: $e');
    return null;
  }
}

Future<Map<String, dynamic>?> readUserData() async {
  print('readUserData');
  try {
    // 저장된 값을 읽어온다
    String? value = await storage.read(key: 'userData');
    print('Data read successfully: $value');

    // 값이 null일 경우 null 반환
    if (value == null) {
      return null;
    }

    // JSON 문자열을 Map으로 변환
    return jsonDecode(value) as Map<String, dynamic>;
  } catch (e) {
    print('Error reading data: $e');
    return null;
  }
}


// 데이터 삭제 함수
Future<void> deleteData(String key) async {
  try {
    await storage.delete(key: key);
    print('Data deleted successfully.');
  } catch (e) {
    print('Error deleting data: $e');
  }
}

// 모든 데이터 삭제 함수
Future<void> deleteAllData() async {
  try {
    await storage.deleteAll();
    print('All data deleted successfully.');
  } catch (e) {
    print('Error deleting all data: $e');
  }
}

// 예시로 유저 ID를 추출하는 함수
Future<String?> getUserId() async {
  final userData = await readUserData();
  if (userData != null && userData.containsKey('user_id')) {
    return userData['user_id'] as String?;
  }
  return null;
}

// 예시로 유저 ID를 추출하는 함수
Future<int?> getUserFav() async {
  final userData = await readUserData();
  if (userData != null && userData.containsKey('favorite_plant_id')) {
    return userData['favorite_plant_id'] as int?;
  }
  return null;
}

Future<void> updateFavoritePlantId(int newFavoritePlantId) async {
  print('updateFavoritePlantId');
  try {
    // 기존의 userData를 읽어옴
    Map<String, dynamic>? userData = await readUserData();

    if (userData != null) {
      // favorite_plant_id를 새 값으로 업데이트
      userData['favorite_plant_id'] = newFavoritePlantId;

      // 업데이트된 userData를 JSON 문자열로 변환하여 저장
      String jsonString = jsonEncode(userData);
      await storage.write(key: 'userData', value: jsonString);

      print('favorite_plant_id updated successfully.');
    } else {
      print('No user data found to update.');
    }
  } catch (e) {
    print('Error updating favorite_plant_id: $e');
  }
}


Future<void> writeUser(User user) async {
  print('writeUser');
  try {
    // User 객체를 JSON 문자열로 변환하여 저장
    String jsonString = jsonEncode(user.toJson());
    await storage.write(key: 'userData', value: jsonString);
    print('User data written successfully.');
  } catch (e) {
    print('Error writing user data: $e');
  }
}

Future<User?> readUser() async {
  print('readUser');
  try {
    // 저장된 값을 읽어온다
    String? value = await storage.read(key: 'userData');
    print('Data read successfully: $value');

    // 값이 null일 경우 null 반환
    if (value == null) {
      return null;
    }

    // JSON 문자열을 Map으로 변환한 후 User 객체로 변환
    Map<String, dynamic> json = jsonDecode(value);
    return User.fromJson(json);
  } catch (e) {
    print('Error reading user data: $e');
    return null;
  }
}


