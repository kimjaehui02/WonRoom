import 'package:flutter/material.dart';

class Validators {
  // 아이디 중복 검사 및 유효성 검사
  static String? validateId(String id) {
    if (id.isEmpty) {
      return '아이디를 입력해주세요.';
    }
    // 중복 검사 로직 (예: 서버와 연동)
    if (id == "wonroom") {
      return '이미 사용 중인 아이디입니다.';
    }
    // 유효성 검사 (예: 길이 제한)
    if (id.length < 4) {
      return '아이디는 4자리 이상이어야 합니다.';
    }
    return '사용 가능한 아이디입니다.';
  }

  // 닉네임 중복 검사 및 유효성 검사
  static String? validateNickname(String? nickname) {
    if (nickname == null || nickname.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    // 중복 검사 로직 (예: 서버와 연동)
    if (nickname == "existing_nickname") {
      return '이미 사용 중인 닉네임입니다.';
    }
    // 유효성 검사 (예: 길이 제한)
    if (nickname.length < 3) {
      return '닉네임은 3자리 이상이어야 합니다.';
    }
    return '사용 가능한 닉네임입니다.';
  }

  // 이메일 유효성 검사
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return '이메일을 입력해주세요.';
    }
    // 이메일 형식 검사
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      return '이메일 형식이 잘못되었습니다.';
    }
    // 중복 검사 로직 (예: 서버와 연동)
    if (email == "existing@example.com") {
      return '이미 사용 중인 이메일입니다.';
    }
    return '사용 가능한 이메일입니다.';
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
