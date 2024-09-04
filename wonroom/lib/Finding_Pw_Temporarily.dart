import 'package:flutter/material.dart';

class FindingPwTemporarily extends StatelessWidget {
  const FindingPwTemporarily({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  '임시 비밀번호 전송이\n완료되었습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '입력하신 이메일로 임시 비밀번호를 발송하였습니다.\n'
                      '이메일을 확인하여 로그인해주세요.',
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
            // 로그인 버튼
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6FB348), // 버튼 배경색 초록색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  '로그인',
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
    );
  }
}
