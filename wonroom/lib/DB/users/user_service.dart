import 'package:dio/dio.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Flask/storage_manager.dart';

class UserService {
  final Dio dio = Dio();
  final String baseUrl = "http://192.168.219.81:8087/";
  final StorageManager _storageManager = StorageManager();

  // 사용자 등록
  Future<void> usersInsert(User user) async {
    final String url = "$baseUrl/users/insert";
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    print("object??????");
    try {
      Response response = await dio.post(url, data: user.toJson());
      print(response.statusCode);
      print(response.realUri);
      print(response.data);
    } catch (e) {
      print("Error: $e");
    }
  }

  // 사용자 로그인
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
  Future<void> usersUpdate(String userPw, String userNick, String userEmail, int? favoritePlantId) async {
    String? userId = await _storageManager.getUserId();

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
          "favorite_plant_id": favoritePlantId
        },
      );

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

  Future<void> updateUserInfo({
    String? userPw,
    String? userNick,
    String? userEmail,
    int? favoritePlantId,
  }) async {
    // 현재 저장된 사용자 정보 읽기
    User? currentUser = await _storageManager.readUser();

    // 저장된 사용자 정보가 없으면 종료
    if (currentUser == null) {
      print('No user data found in storage');
      return;
    }

    // 입력된 값으로 사용자 정보를 업데이트
    final updatedUser = User(
      userId: currentUser.userId, // 기존 userId 유지
      userPw: userPw ?? currentUser.userPw,
      userNick: userNick ?? currentUser.userNick,
      userEmail: userEmail ?? currentUser.userEmail,
      regDate: currentUser.regDate, // 변경하지 않음
      favoritePlantId: favoritePlantId ?? currentUser.favoritePlantId,
    );

    // 업데이트할 데이터 준비
    final String url = "$baseUrl/users/update";

    try {
      Response response = await dio.post(
        url,
        data: updatedUser.toJson(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == 'success') {
          print('User information updated successfully.');
          // 업데이트된 사용자 정보를 다시 저장 (선택 사항)
          await _storageManager.writeUser(updatedUser);
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
    String? userId = await _storageManager.getUserId();

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
        },
      );

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

  // 사용자 정보 가져오기
  Future<User?> getUserInfo() async {
    final String url = "$baseUrl/users/get_user_info"; // 서버에서 사용자 정보를 가져오는 API 엔드포인트

    String? userId = await _storageManager.getUserId();

    if (userId == null) {
      print('No user_id found in storage');
      return null;
    }

    try {
      Response response = await dio.post(
        url,
        data: {
          "user_id": userId,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['status'] == 'success') {
          // 서버에서 받은 데이터로 User 객체 생성
          final user = User.fromJson(responseData['user']);
          return user;
        } else {
          print('Failed to get user info: ${responseData['message']}');
          return null;
        }
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
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

  // 즐겨 찾기 식물 ID 업데이트
  Future<void> updateFavoritePlantIdService(int newFavoritePlantId) async {
    // 사용자 정보 읽기
    User? currentUser = await _storageManager.readUser();

    if (currentUser == null) {
      print('No user data found in storage');
      return;
    }

    // Null 체크 후 예외 처리
    if (currentUser.userPw == null || currentUser.userNick == null || currentUser.userEmail == null) {
      throw Exception('User information is incomplete.');
    }

    // 기존 사용자 정보를 유지하면서 favorite_plant_id만 업데이트
    await usersUpdate(
      currentUser.userPw!,  // null이 아님을 보장
      currentUser.userNick!,
      currentUser.userEmail!,
      newFavoritePlantId,
    );

    // 업데이트된 사용자 정보를 다시 저장 (선택 사항)
    currentUser.favoritePlantId = newFavoritePlantId;
    await _storageManager.writeUser(currentUser);
  }
}
