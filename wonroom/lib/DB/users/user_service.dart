import 'package:dio/dio.dart';
import 'package:wonroom/Flask/storage_manager.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// 회원 가입 요청
void usersInsert(String user_id, String user_pw, String user_nick, String user_email) async {
  print(user_id);
  final String url = "$baseUrl/users/insert";

  try {
    Response res = await dio.post(url,
        data: {
          "user_id": user_id,
          "user_pw": user_pw,
          "user_nick": user_nick,
          "user_email": user_email,
          "reg_date": DateTime.now().toIso8601String(),
        });

    print(res.statusCode);
    print(res.realUri);
    print(res.data);
  } catch (e) {
    print("Error: $e");
  }
}

void usersLogin(String user_id, String user_pw) async {
  final String url = "$baseUrl/users/login";

  try {
    Response response = await dio.post(
      url,
      data: {
        "user_id": user_id,
        "user_pw": user_pw,
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response URL: ${response.realUri}');
    print('Response Data: ${response.data}');

    // 서버 응답이 JSON 형식일 경우
    if (response.statusCode == 200) {
      final responseData = response.data;

      // JSON 데이터로 응답을 처리하는 예제
      if (responseData['status'] == 'success') {
        // 로그인 성공 처리
        await writeData('user_id', user_id);
      } else {
        // 로그인 실패 처리
        print('Login failed: ${responseData['message']}');
      }
    } else {
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}


/// 사용자 정보를 업데이트하는 함수
void usersUpdate(String user_pw, String user_nick, String user_email) async {
  // 스토리지에서 user_id 읽어오기
  String? user_id = await storage.read(key: 'user_id');

  if (user_id == null) {
    print('No user_id found in storage');
    return;
  }

  final String url = "$baseUrl/users/update";

  try {
    Response response = await dio.post(
      url,
      data: {
        "user_id": user_id,
        "user_pw": user_pw,
        "user_nick": user_nick,
        "user_email": user_email,
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response URL: ${response.realUri}');
    print('Response Data: ${response.data}');

    // 서버 응답이 JSON 형식일 경우
    if (response.statusCode == 200) {
      final responseData = response.data;

      // JSON 데이터로 응답을 처리하는 예제
      if (responseData['status'] == 'success') {
        // 업데이트 성공 처리
        print('User information updated successfully.');
      } else {
        // 업데이트 실패 처리
        print('Update failed: ${responseData['message']}');
      }
    } else {
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}

void usersDelete() async {
  final String url = "$baseUrl/users/delete";
  String? user_id = await storage.read(key: 'user_id');
  try {
    Response response = await dio.post(
      url,
      data: {
        "user_id": user_id,
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response URL: ${response.realUri}');
    print('Response Data: ${response.data}');

    // 서버 응답이 JSON 형식일 경우
    if (response.statusCode == 200) {
      final responseData = response.data;

      // JSON 데이터로 응답을 처리하는 예제
      if (responseData['status'] == 'success') {
        // 삭제 성공 처리
        print('User deleted successfully.');
      } else {
        // 삭제 실패 처리
        print('Deletion failed: ${responseData['message']}');
      }
    } else {
      print('Unexpected status code: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}
