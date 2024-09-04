import 'package:flutter/material.dart';
import 'package:wonroom/findingPw.dart';
import 'package:wonroom/login.dart';

class FindingIdSuccess extends StatelessWidget {
  const FindingIdSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이디 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼들을 하단에 위치
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 이미지 추가 및 색상 필터 적용
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xff6FB348), // 연두색
                    BlendMode.srcIn, // 색상 혼합 모드
                  ),
                  child: Image.asset(
                    'images/회원가입체크.png',
                    width: 100, // 이미지 너비
                    height: 100, // 이미지 높이
                  ),
                ),
                const Text(
                  '아이디 찾기를 성공하였습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '아이디 확인 후 로그인해 주세요.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
                // 이메일 입력란
                TextField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                  ),
                  enabled: false, // 이메일 입력창 비활성화
                ),
              ],
            ),
            Column(
              children: [
                // 비밀번호 찾기 버튼
                SizedBox(
                  width: double.infinity, // 버튼이 전체 너비를 차지하도록 설정
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindingPw()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.black, // 테두리 색상
                        width: 1.5, // 테두리 두께
                      ),
                      minimumSize: const Size(double.infinity, 48), // 버튼의 최소 높이 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 모서리 곡선 제거
                      ),
                    ),
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                          color: Colors.black, // 버튼 글씨 색상
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // 로그인 버튼
                SizedBox(
                  width: double.infinity, // 버튼이 전체 너비를 차지하도록 설정
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6FB348), // 버튼 배경색 초록색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), // 모서리 곡선 제거
                      ),
                      minimumSize: const Size(double.infinity, 48), // 버튼의 최소 높이 설정
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                          color: Colors.white, // 버튼 글씨 색상 흰색
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
