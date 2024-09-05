import 'package:flutter/material.dart';

class CommonValidators {
  static String? validateUserId(String? value) {
    if (value == null || value.isEmpty) {
      return '아이디를 입력해 주세요.';
    }
    if (value.length < 4) {
      return '아이디는 4자리 이상이어야 합니다.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해 주세요.';
    }
    if (value.length < 8) {
      return '비밀번호는 8자리 이상이어야 합니다.';
    }
    return null;
  }

  static String? validatePasswordConfirm(String? value, String password) {
    if (value == null || value.isEmpty) {
      return '비밀번호 확인을 입력해 주세요.';
    }
    if (value != password) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  static String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해 주세요.';
    }
    if (value.length < 3) {
      return '닉네임은 3자리 이상이어야 합니다.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해 주세요.';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return '유효한 이메일 주소를 입력해 주세요.';
    }
    return null;
  }
}
