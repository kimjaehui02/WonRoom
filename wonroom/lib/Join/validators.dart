// validators.dart
import 'package:flutter/material.dart';
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/Join/controllers.dart';


class Validators {
  // 아이디 중복 검사 및 유효성 검사
  static Future<String?> validateId(String id) async {
    if (id.isEmpty) {
      return '아이디를 입력해주세요.';
    }



    if (id.length < 4) {
      return '아이디는 4자리 이상이어야 합니다.';
    }

    final result = await checkUserId(id);
    if (!result) {
      return '중복된 아이디 입니다.';
    }
    return '사용 가능한 아이디 입니다.';
  }

  // 닉네임 중복 검사 및 유효성 검사
  static Future<String?> validateNickname(String? nickname) async {
    if (nickname == null || nickname.isEmpty) {
      return '닉네임을 입력해주세요.';
    }



    if (nickname.length < 3) {
      return '닉네임은 3자리 이상이어야 합니다.';
    }

    final result = await checkUserNickname(nickname);
    if (!result) {
      return '중복된 닉네임 입니다.';
    }

    return '사용 가능한 닉네임 입니다.';
  }

  // 이메일 유효성 검사
  static Future<String?> validateEmail(String? email) async {
    if (email == null || email.isEmpty) {
      return '이메일을 입력해주세요.';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      print(email);
      print('이메일 형식이 잘못되었습니다.');
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

  // 모든 필드의 유효성 검사
  static Future<bool> validateAll(String id, String? nickname, String? email) async {
    final idValid = await validateId(id);
    final nicknameValid = await validateNickname(nickname);
    final emailValid = await validateEmail(email);

    print(idValid);
    print(nicknameValid);
    print(emailValid);

    // 모든 필드가 유효한지 확인
    return idValid == '사용 가능한 아이디 입니다.' &&
        nicknameValid == '사용 가능한 닉네임 입니다.' &&
        emailValid == '사용 가능한 이메일 입니다.';
  }

  static void showSuccessDialog(context, FormControllers _formControllers)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '회원가입 완료',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  '지금 바로 건강한 반려식물\n관리를 시작해보세요.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      usersInsert(_formControllers.idController.text,
                                  _formControllers.passwordController.text,
                                  _formControllers.nicknameController.text,
                                  _formControllers.emailController.text);
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showErrorDialog(context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '회원가입 실패',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // 실패를 나타내는 색상
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  errorMessage, // 전달된 오류 메시지를 표시합니다.
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red, // 실패 메시지 색상
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // 실패 버튼 색상
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
