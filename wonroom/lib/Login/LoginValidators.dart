import 'package:flutter/material.dart';
import 'package:wonroom/DB/users/common_validators.dart';
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/Flask/storage_manager.dart';
import 'package:wonroom/Join/controllers.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart';

// 로그인 관련 유효성 검사 클래스를 정의합니다.
class LoginValidators {
  // 아이디 유효성 검사
  static String? validateUserId(String? value) {
    // 공통 유효성 검사 로직을 호출합니다.
    return CommonValidators.validateUserId(value);
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? value) {
    // 공통 유효성 검사 로직을 호출합니다.
    return CommonValidators.validatePassword(value);
  }

  // 비밀번호 확인 유효성 검사
  static String? validatePasswordConfirm(String? value, String password) {
    // 공통 유효성 검사 로직을 호출합니다.
    return CommonValidators.validatePasswordConfirm(value, password);
  }

  // 닉네임 유효성 검사
  static String? validateNickname(String? value) {
    // 공통 유효성 검사 로직을 호출합니다.
    return CommonValidators.validateNickname(value);
  }

  // 이메일 유효성 검사
  static String? validateEmail(String? value) {
    // 공통 유효성 검사 로직을 호출합니다.
    return CommonValidators.validateEmail(value);
  }

  static bool buttonAble(String id, String pw)
  {
    final idValid = validateUserId(id);
    final pwValid = validatePassword(pw);
    if (idValid != null) return false;
    if (pwValid != null) return false;
    return true;

  }

  static Future<String?> validateLogin(String id, String pw) async {
    // 아이디와 비밀번호 검증
    print("final idValid = validateUserId(id);");
    final idValid = validateUserId(id);
    print("final pwValid = validatePassword(pw);");
    final pwValid = validatePassword(pw);

    // 유효성 검사 실패 시 메시지 반환
    if (idValid != null) return '아이디는 4자리 이상이어야 합니다.';
    if (pwValid != null) return '비밀번호는 8자리 이상이어야 합니다.';

    // 로그인 검사 시도
    try {
      print("final result = await usersLogin(id, pw);");
      final result = await usersLogin(id, pw);

      // 로그인 성공 여부 확인
      if (result["status"] == "success") {
        writeUserData('userData', result);
        return '환영합니다.';
      } else {
        return '로그인 정보가 없습니다.';
      }
    } catch (e) {
      // 예외 발생 시 오류 메시지 반환
      print("Error during login: $e");
      return '로그인 정보가 없습니다.';
    }
  }



  // 성공 다이얼로그 표시
  static void showSuccessDialog(BuildContext context, String input) {
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
                  input,
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

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Index()),
                      );
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

  // 실패 다이얼로그 표시
  static void showErrorDialog(BuildContext context, String errorMessage) {
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
                  errorMessage,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
