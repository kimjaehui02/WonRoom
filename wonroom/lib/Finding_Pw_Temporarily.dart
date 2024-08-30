import 'package:flutter/material.dart';

class FindingPwTemporarily extends StatelessWidget {
  const FindingPwTemporarily({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼을 하단에 위치
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 이미지 추가 및 색상 필터 적용
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xFFB2FF59), // 연두색
                    BlendMode.srcIn, // 색상 혼합 모드
                  ),
                  child: Image.asset(
                    'images/회원가입체크.png',
                    width: 100, // 이미지 너비
                    height: 100, // 이미지 높이
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '임시 비밀번호 전송이\n 완료되었습니다.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '입력하신 이메일로 임시 비밀번호를 발송하였습니다.\n'
                      '이메일을 확인하여 로그인해주세요.',
                  style: TextStyle(
                    fontSize: 17.0,
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
            SizedBox(
              width: double.infinity, // 버튼이 전체 너비를 차지하도록 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login'); // 로그인 페이지로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6FB348), // 버튼 배경색 초록색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 모서리 곡선 제거
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
      ),
    );
  }
}
