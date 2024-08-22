import 'package:flutter/material.dart';

class FormControllers {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();

  final idFocusNode = FocusNode();
  final nicknameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();


  bool isIdDuplicate = false; // 중복된 아이디 확인
  bool isNicknameDuplicate = false; // 중복된 닉네임 확인
  bool isEmailDuplicate = false; // 중복된 이메일 확인
  bool isButtonEnabled = true; // 버튼 활성화 상태

  void dispose() {
    idController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    nicknameController.dispose();
    emailController.dispose();
    idFocusNode.dispose(); // FocusNode 리소스 해제
    nicknameFocusNode.dispose(); // 추가
    emailFocusNode.dispose(); // 추가
  }
}
