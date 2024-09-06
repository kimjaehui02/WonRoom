import 'package:flutter/material.dart';
import 'package:wonroom/index.dart';
import 'package:wonroom/join.dart';
import 'package:wonroom/login.dart';
import 'package:wonroom/main.dart';
import 'package:wonroom/splash.dart';

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
                padding: const EdgeInsets.all(16),
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
                              color: Color(0xff779d60),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSerifDisplay',
                              letterSpacing: 2,
                              fontSize: 42,
                            ),
                          ),
                          TextSpan(
                            text: '-Room', // 나머지 부분
                            style: TextStyle(
                              color: Color(0xff595959),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DMSerifDisplay',
                              letterSpacing: 1,
                              fontSize: 42,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // 두 텍스트 사이의 공간
                    Text(
                      '언제 어디서나 간편하게 \n 건강한 식물 키우기', // 두 번째 텍스트
                      style: TextStyle(fontSize: 18, color: Color(0xff333333)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 최소한의 높이로 설정
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      // showNotification();
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
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // 버튼 크기 조정
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12), // 두 버튼 사이의 공간
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // 회원가입 버튼 클릭 시 동작
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Join()),
                      );
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Index()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      // side: BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // 버튼 크기 조정
                    ),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
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
