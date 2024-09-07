import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Flask/Notification.dart';

class StorageManager {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // 데이터 저장 함수
  Future<void> writeData(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      print('Data written successfully.');
    } catch (e) {
      print('Error writing data: $e');
    }
  }

  Future<void> writeUserData(Map<String, dynamic> value) async {
    try {
      String jsonString = jsonEncode(value);
      await _storage.write(key: 'userData', value: jsonString);
      print('Data written successfully.');
    } catch (e) {
      print('Error writing data: $e');
    }
  }

  Future<void> writeNotifications(List<Notification> notifications) async {
    try {
      List<Map<String, dynamic>> jsonList = notifications.map((n) => n.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      await _storage.write(key: 'notifications', value: jsonString);
      print('Notifications written successfully.');
    } catch (e) {
      print('Error writing notifications: $e');
    }
  }

  // 데이터 읽기 함수
  Future<String?> readData(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      print('Error reading data: $e');
      return null;
    }
  }

  Future<int?> readDataAsInt(String key) async {
    try {
      String? value = await _storage.read(key: key);
      return value != null ? int.tryParse(value) : null;
    } catch (e) {
      print('Error reading data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> readUserData() async {
    try {
      String? value = await _storage.read(key: 'userData');
      return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
    } catch (e) {
      print('Error reading data: $e');
      return null;
    }
  }

  Future<List<Notification>?> readNotifications() async {
    try {
      String? value = await _storage.read(key: 'notifications');
      if (value != null) {
        List<dynamic> jsonList = jsonDecode(value);
        return jsonList.map((json) => Notification.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      print('Error reading notifications: $e');
      return null;
    }
  }

  // 데이터 삭제 함수
  Future<void> deleteData(String key) async {
    try {
      await _storage.delete(key: key);
      print('Data deleted successfully.');
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  // 모든 데이터 삭제 함수
  Future<void> deleteAllData() async {
    try {
      await _storage.deleteAll();
      print('All data deleted successfully.');
    } catch (e) {
      print('Error deleting all data: $e');
    }
  }

  Future<String?> getUserId() async {
    final userData = await readUserData();
    return userData?['user_id'] as String?;
  }

  Future<int?> getUserFav() async {
    final userData = await readUserData();
    return userData?['favorite_plant_id'] as int?;
  }

  Future<void> updateFavoritePlantId(int newFavoritePlantId) async {
    try {
      Map<String, dynamic>? userData = await readUserData();
      if (userData != null) {
        userData['favorite_plant_id'] = newFavoritePlantId;
        String jsonString = jsonEncode(userData);
        await _storage.write(key: 'userData', value: jsonString);
        print('favorite_plant_id updated successfully.');
      } else {
        print('No user data found to update.');
      }
    } catch (e) {
      print('Error updating favorite_plant_id: $e');
    }
  }

  Future<void> writeUser(User user) async {
    try {
      String jsonString = jsonEncode(user.toJson());
      await _storage.write(key: 'userData', value: jsonString);
      print('User data written successfully.');
    } catch (e) {
      print('Error writing user data: $e');
    }
  }

  Future<User?> readUser() async {
    try {
      String? value = await _storage.read(key: 'userData');
      if (value == null) return null;
      Map<String, dynamic> json = jsonDecode(value);
      return User.fromJson(json);
    } catch (e) {
      print('Error reading user data: $e');
      return null;
    }
  }
}


