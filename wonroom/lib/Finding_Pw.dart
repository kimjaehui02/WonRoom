import 'package:flutter/material.dart';
import 'package:wonroom/Finding_Pw_Temporarily.dart';

class FindingPw extends StatelessWidget {
  const FindingPw({super.key});

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '일치하는 정보가 없습니다.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0, // 제목 텍스트 크기
            ),
            textAlign: TextAlign.center, // 제목 텍스트 가운데 정렬
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0), // 내용 상하 여백
            child: SizedBox(
              width: 300.0, // 모달창 너비
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '아이디 또는 이메일을 확인해주세요.',
                    style: TextStyle(
                        fontSize: 18.0, // 내용 텍스트 크기
                        color: Colors.grey),
                    textAlign: TextAlign.center, // 내용 텍스트 가운데 정렬
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 모달창 모서리 둥글기
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 4.0), // 버튼의 패딩 조절
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    // 버튼 배경색
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 24.0),
                    // 버튼 여백 조정
                    foregroundColor: Colors.white,
                    // 버튼 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // 버튼 직사각형 모서리
                    ),
                    textStyle: const TextStyle(
                      fontSize: 22.0, // 버튼 텍스트 크기
                      fontWeight: FontWeight.bold, // 버튼 텍스트 굵기
                    ),
                  ),
                  child: const Text('확인'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
        title: const Text('비밀번호 찾기'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Text(
                          '아이디',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        errorStyle: TextStyle(
                          color: Colors.red, // 에러 메시지의 색상
                          fontSize: 12, // 에러 메시지의 글자 크기
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: const <Widget>[
                        Text(
                          '이메일',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                      ),
                    ),
                    const SizedBox(height: 30.0), // 필드와 버튼 사이의 간격
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showErrorDialog(context); // 비밀번호 찾기 버튼 클릭 시 다이얼로그 표시, 오류 시
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FindingPwTemporarily()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff6bbe45),
                  // 버튼 배경색
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  // 버튼 위아래 여백 조정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 직사각형 모양
                  ),
                ),
                child: const Text(
                  '비밀번호 찾기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold), // 버튼 텍스트 색상과 크기
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
