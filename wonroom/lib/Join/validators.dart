import 'package:flutter/material.dart';
import 'package:wonroom/DB/users/common_validators.dart';
import 'package:wonroom/DB/users/user_service.dart';
import 'package:wonroom/DB/users/users_model.dart';
import 'package:wonroom/Join/controllers.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart';

// 회원가입과 관련된 유효성 검사를 수행하는 클래스
class Validators {
  // 아이디 중복 검사 및 유효성 검사
  static Future<String?> validateId(String id) async {
    final idValid = CommonValidators.validateUserId(id);
    if (idValid != null) return idValid;

    UserService _us = new UserService();
    final result = await _us.checkUserId(id);
    if (!result) {
      return '중복된 아이디 입니다.';
    }
    return '사용 가능한 아이디 입니다.';
  }

  // 닉네임 중복 검사 및 유효성 검사
  static Future<String?> validateNickname(String? nickname) async {
    final nicknameValid = CommonValidators.validateNickname(nickname);
    if (nicknameValid != null) return nicknameValid;

    UserService _us = new UserService();
    final result = await _us.checkUserNickname(nickname!);
    if (!result) {
      return '중복된 닉네임 입니다.';
    }
    return '사용 가능한 닉네임 입니다.';
  }

  // 이메일 유효성 검사
  static Future<String?> validateEmail(String? email) async {
    final emailValid = CommonValidators.validateEmail(email);
    if (emailValid != null) return emailValid;

    UserService _us = new UserService();
    final result = await _us.checkUserEmail(email!);
    if (!result) {
      return '중복된 이메일 입니다.';
    }
    return '사용 가능한 이메일 입니다.';
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? password) {
    return CommonValidators.validatePassword(password);
  }

  // 비밀번호 확인
  static String? validateConfirmPassword(String? confirmPassword, String password) {
    return CommonValidators.validatePasswordConfirm(confirmPassword, password);
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

  // 성공 다이얼로그 표시
  static void showSuccessDialog(BuildContext context, FormControllers formControllers) {
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

                      UserService userService = new UserService();
                      User user = new User(userId:  formControllers.idController.text,
                          userPw:  formControllers.passwordController.text,
                          userNick:  formControllers.nicknameController.text,
                          userEmail:  formControllers.emailController.text,
                          regDate:  DateTime.now());

                      userService.usersInsert(user);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Intro()),
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '회원가입 실패',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.0),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    onPressed: () {
                      // 로그아웃 기능

                      Navigator.of(context).pop();
                    },
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
