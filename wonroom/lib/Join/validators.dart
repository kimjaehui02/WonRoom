// validators.dart
import 'package:wonroom/DB/users/user_service.dart';


class Validators {
  // 아이디 중복 검사 및 유효성 검사
  static Future<String?> validateId(String id) async {
    if (id.isEmpty) {
      return '아이디를 입력해주세요.';
    }

    final result = await checkUserId(id);
    if (!result) {
      return '중복된 아이디 입니다.';
    }

    if (id.length < 4) {
      return '아이디는 4자리 이상이어야 합니다.';
    }
    return '사용 가능한 아이디 입니다.';
  }

  // 닉네임 중복 검사 및 유효성 검사
  static Future<String?> validateNickname(String? nickname) async {
    if (nickname == null || nickname.isEmpty) {
      return '닉네임을 입력해주세요.';
    }

    final result = await checkUserNickname(nickname);
    if (!result) {
      return '중복된 닉네임 입니다.';
    }

    if (nickname.length < 3) {
      return '닉네임은 3자리 이상이어야 합니다.';
    }
    return '사용 가능한 닉네임 입니다.';
  }

  // 이메일 유효성 검사
  static Future<String?> validateEmail(String? email) async {
    if (email == null || email.isEmpty) {
      return '이메일을 입력해주세요.';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      return '이메일 형식이 잘못되었습니다.';
    }

    final result = await checkUserEmail(email);
    if (!result) {
      return '중복된 이메일 입니다.';
    }
    return '사용 가능한 이메일 입니다.';
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? password) {
    if (password == null || password.length < 8) {
      return '비밀번호는 8자리 이상이어야 합니다.';
    }
    return null;
  }

  // 비밀번호 확인
  static String? validateConfirmPassword(String? confirmPassword, String password) {
    if (confirmPassword != password) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }
}
