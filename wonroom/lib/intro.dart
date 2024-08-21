import 'package:flutter/material.dart';
import 'package:wonroom/join.dart';
import 'package:wonroom/login.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 중앙에 위치할 텍스트들
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 최소한의 높이로 설정
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Won', // 초록색으로 할 부분
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600], // 초록색으로 설정
                            ),
                          ),
                          TextSpan(
                            text: '-Room', // 나머지 부분
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // 검정색으로 설정
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // 두 텍스트 사이의 공간
                    Text(
                      '언제 어디서나 간편하게 \n 건강한 식물 키우기', // 두 번째 텍스트
                      style: TextStyle(fontSize: 21, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 하단에 위치할 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 최소한의 높이로 설정
              children: [
                Container(
                  width: 350, // 버튼의 너비 설정
                  child: ElevatedButton(
                    onPressed: () {
                      // 로그인 버튼 클릭 시 동작
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 직사각형 모양
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15), // 버튼 크기 조정
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.black, // 텍스트 색상
                        fontSize: 23, // 글자 크기
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 13), // 두 버튼 사이의 공간
                Container(
                  width: 350, // 버튼의 너비 설정
                  child: ElevatedButton(
                    onPressed: () {
                      // 회원가입 버튼 클릭 시 동작
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Join()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 직사각형 모양
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15), // 버튼 크기 조정
                    ),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.white, // 텍스트 색상
                        fontSize: 23, // 글자 크기
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
