import 'package:flutter/material.dart';
import 'package:wonroom/Finding_Pw.dart';
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
          icon: Icon(
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
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindingPw()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 로그인 버튼
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6FB348),
                      // side: BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // 버튼 크기 조정
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.white, // 텍스트 색상
                        fontSize: 18, // 글자 크기
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
