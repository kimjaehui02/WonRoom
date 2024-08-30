import 'package:flutter/material.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/intro.dart'; // Index 페이지를 불러옵니다

// 일정 시간이 지나면 화면을 이동하는 함수
void navigateToJoin(BuildContext context, {int duration = 3}) {
  Future.delayed(Duration(seconds: duration), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Intro()), // Index 페이지로 이동
    );
  });
}
