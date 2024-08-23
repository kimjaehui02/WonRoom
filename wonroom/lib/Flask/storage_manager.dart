import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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