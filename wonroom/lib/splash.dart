import 'package:flutter/material.dart';
import 'package:wonroom/join.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
                    // 이미지 추가
                    Image.asset(
                      'images/스플래시2.png', // 이미지 경로 (프로젝트의 assets 폴더 내에 위치)
                      height: 110, // 이미지의 높이 조정
                      width: 110, // 이미지의 너비 조정
                    ),
                    SizedBox(height: 3), // 이미지와 텍스트 사이의 공간
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Won', // 초록색으로 할 부분
                            style: TextStyle(
                              color: Colors.green,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
