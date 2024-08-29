import 'package:dio/dio.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';

final Dio dio = Dio();
final String baseUrl = "http://192.168.219.81:8087/";

// <editor-fold desc="구형 코드들">

// 회원 가입 요청
// void usersInsert(String user_id, String user_pw, String user_nick, String user_email) async {
//   print(user_id);
//   final String url = "$baseUrl/users/insert";
//
//   try {
//     Response res = await dio.post(url,
//         data: {
//           "user_id": user_id,
//           "user_pw": user_pw,
//           "user_nick": user_nick,
//           "user_email": user_email,
//           "reg_date": DateTime.now().toIso8601String(),
//         });
//
//     print(res.statusCode);
//     print(res.realUri);
//     print(res.data);
//   } catch (e) {
//     print("Error: $e");
//   }
// }

// 로그인
// Future<Map<String, dynamic>> usersLogin(String userId, String userPw) async {
//   final String url = "$baseUrl/users/login";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "user_id": userId,
//         "user_pw": userPw,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     // 서버 응답이 JSON 형식일 경우
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//
//       // JSON 데이터로 응답을 처리하는 예제
//       if (responseData['status'] == 'success') {
//         // 로그인 성공 처리
//         return responseData; // 로그인 성공 시 응답 데이터 반환
//       } else {
//         // 로그인 실패 처리
//         throw Exception('Login failed: ${responseData['message']}');
//       }
//     } else {
//       throw Exception('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//     throw Exception('Error occurred: $e'); // 예외 발생
//   }
// }

// 아이디 찾기
// Future<Map<String, dynamic>> findIdByNickEmail(String userNick, String userEmail) async {
//   final String url = "$baseUrl/users/find_id_by_nick_email";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "user_nick": userNick,
//         "user_email": userEmail,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     // 서버 응답이 JSON 형식일 경우
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//
//       if (responseData['status'] == 'success') {
//         // 조회 성공 처리
//         return responseData; // 성공 시 응답 데이터 반환
//       } else {
//         // 조회 실패 처리
//         throw Exception('Find ID failed: ${responseData['message']}');
//       }
//     } else {
//       throw Exception('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//     throw Exception('Error occurred: $e'); // 예외 발생
//   }
// }

/// 사용자 정보를 업데이트하는 함수
// void usersUpdate(String user_pw, String user_nick, String user_email) async {
//   // 스토리지에서 user_id 읽어오기
//   String? user_id = await storage.read(key: 'user_id');
//
//   if (user_id == null) {
//     print('No user_id found in storage');
//     return;
//   }
//
//   final String url = "$baseUrl/users/update";
//
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "user_id": user_id,
//         "user_pw": user_pw,
//         "user_nick": user_nick,
//         "user_email": user_email,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     // 서버 응답이 JSON 형식일 경우
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//
//       // JSON 데이터로 응답을 처리하는 예제
//       if (responseData['status'] == 'success') {
//         // 업데이트 성공 처리
//         print('User information updated successfully.');
//       } else {
//         // 업데이트 실패 처리
//         print('Update failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }

// void usersDelete() async {
//   final String url = "$baseUrl/users/delete";
//   String? user_id = await storage.read(key: 'user_id');
//   try {
//     Response response = await dio.post(
//       url,
//       data: {
//         "user_id": user_id,
//       },
//     );
//
//     print('Status Code: ${response.statusCode}');
//     print('Response URL: ${response.realUri}');
//     print('Response Data: ${response.data}');
//
//     // 서버 응답이 JSON 형식일 경우
//     if (response.statusCode == 200) {
//       final responseData = response.data;
//
//       // JSON 데이터로 응답을 처리하는 예제
//       if (responseData['status'] == 'success') {
//         // 삭제 성공 처리
//         print('User deleted successfully.');
//       } else {
//         // 삭제 실패 처리
//         print('Deletion failed: ${responseData['message']}');
//       }
//     } else {
//       print('Unexpected status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }


// <editor-fold desc="회원가입용 아이디, 닉네임, 이메일중복검사">
// 아이디 중복 검사
Future<bool> checkUserId(String user_id) async {
  final String url = "$baseUrl/users/check_id";

  try {
    Response response = await dio.post(
      url,
      data: {"user_id": user_id},
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      return responseData['status'] == 'success';
    } else {
      print('Unexpected status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

// 닉네임 중복 검사
Future<bool> checkUserNickname(String user_nick) async {
  final String url = "$baseUrl/users/check_nickname";

  try {
    Response response = await dio.post(
      url,
      data: {"user_nick": user_nick},
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      return responseData['status'] == 'success';
    } else {
      print('Unexpected status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

// 이메일 중복 검사
Future<bool> checkUserEmail(String user_email) async {
  final String url = "$baseUrl/users/check_email";

  try {
    Response response = await dio.post(
      url,
      data: {"user_email": user_email},
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      return responseData['status'] == 'success';
    } else {
      print('Unexpected status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}
// </editor-fold>

// </editor-fold>

// UserService 클래스
class UserService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";

  // 회원 가입 요청
  Future<void> usersInsert(User user) async {
    final String url = "$baseUrl/users/insert";

    try {
      Response response = await dio.post(url, data: user.toJson());
      print(response.statusCode);
      print(response.realUri);
      print(response.data);
    } catch (e) {
      print("Error: $e");
    }
  }

  // 로그인
  Future<Map<String, dynamic>> usersLogin(String userId, String userPw) async {
    final String url = "$baseUrl/users/login";

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
          "user_pw": userPw,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == 'success') {
          return responseData;
        } else {
          throw Exception('Login failed: ${responseData['message']}');
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error occurred: $e');
    }
  }

  // 아이디 찾기
  Future<Map<String, dynamic>> findIdByNickEmail(String userNick, String userEmail) async {
    final String url = "$baseUrl/users/find_id_by_nick_email";

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_nick": userNick,
          "user_email": userEmail,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == 'success') {
          return responseData;
        } else {
          throw Exception('Find ID failed: ${responseData['message']}');
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error occurred: $e');
    }
  }

  // 사용자 정보 업데이트
  Future<void> usersUpdate(String userPw, String userNick, String userEmail) async {
    String? userId = await storage.read(key: 'user_id');

    if (userId == null) {
      print('No user_id found in storage');
      return;
    }

    final String url = "$baseUrl/users/update";

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
          "user_pw": userPw,
          "user_nick": userNick,
          "user_email": userEmail,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response URL: ${response.realUri}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == 'success') {
          print('User information updated successfully.');
        } else {
          print('Update failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // 사용자 삭제
  Future<void> usersDelete() async {
    final String url = "$baseUrl/users/delete";
    String? userId = await storage.read(key: 'user_id');

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
          print('User deleted successfully.');
        } else {
          print('Deletion failed: ${responseData['message']}');
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // 아이디 중복 검사
  Future<bool> checkUserId(String userId) async {
    final String url = "$baseUrl/users/check_id";

    try {
      Response response = await dio.post(
        url,
        data: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status'] == 'success';
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // 닉네임 중복 검사
  Future<bool> checkUserNickname(String userNick) async {
    final String url = "$baseUrl/users/check_nickname";

    try {
      Response response = await dio.post(
        url,
        data: {"user_nick": userNick},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status'] == 'success';
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  // 이메일 중복 검사
  Future<bool> checkUserEmail(String userEmail) async {
    final String url = "$baseUrl/users/check_email";

    try {
      Response response = await dio.post(
        url,
        data: {"user_email": userEmail},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['status'] == 'success';
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
